#!/usr/bin/env -S nvim -l
-- Static checks for this config: formatting (stylua), lint (selene), and
-- types (lua-language-server). Run from anywhere: ./scripts/check.lua
-- Runs every check, then exits non-zero if any failed.

local root = vim.fn.fnamemodify(arg[0], ':p:h:h')
local targets = { 'lua', 'init.lua', 'scripts' }

---@param cmd string[]
---@param filter? fun(output: string): string
---@return boolean ok
local function run(cmd, filter)
  io.write(('\n==> %s\n'):format(table.concat(cmd, ' ')))
  local result = vim.system(cmd, { cwd = root, text = true }):wait()
  local output = (result.stdout or '') .. (result.stderr or '')
  io.write(filter and filter(output) or output)
  return result.code == 0
end

-- lua-language-server config for `--check`. Inside Neovim, lazydev.nvim
-- supplies the runtime and library settings; outside it, they're added here
-- on top of .luarc.json (which `--configpath` would otherwise bypass). Uses
-- lazydev's non-`lua_root` layout: plugin roots as libraries, resolved
-- through a strict `lua/` require path, like this repo's own modules.
---@return string path
local function luals_config()
  local config = {}
  local rc = io.open(vim.fs.joinpath(root, '.luarc.json'))
  if rc then
    config = vim.json.decode(rc:read('*a'))
    rc:close()
  end

  local library = { vim.env.VIMRUNTIME, '${3rd}/luv/library' }
  -- lazy.nvim's default install root; lua/config/lazy.lua doesn't change it.
  local lazy_root = vim.fs.joinpath(vim.fn.stdpath('data'), 'lazy')
  for name, kind in vim.fs.dir(lazy_root) do
    local plugin = vim.fs.joinpath(lazy_root, name)
    if
      kind == 'directory' and vim.uv.fs_stat(vim.fs.joinpath(plugin, 'lua'))
    then
      table.insert(library, plugin)
    end
  end

  config['runtime.version'] = 'LuaJIT'
  config['runtime.path'] = { 'lua/?.lua', 'lua/?/init.lua' }
  config['runtime.pathStrict'] = true
  config['workspace.checkThirdParty'] = false
  config['workspace.library'] = library

  local path = vim.fn.tempname() .. '.json'
  local f = assert(io.open(path, 'w'))
  f:write(vim.json.encode(config))
  f:close()
  return path
end

-- Prefer mason's copy: it's the one the editor runs (mason prepends its bin to
-- Neovim's PATH), so CLI and editor diagnostics come from the same version.
local luals =
  vim.fs.joinpath(vim.fn.stdpath('data'), 'mason/bin/lua-language-server')
if vim.fn.executable(luals) == 0 then
  luals = 'lua-language-server'
end

local results = {
  run(vim.list_extend({ 'stylua', '--check' }, targets)),
  run(vim.list_extend({ 'selene' }, targets)),
  -- Values go in separate args: LuaLS rewrites `--check=<path>` with a gsub
  -- that also mangles any `--word` inside the path (script/cli/check.lua).
  run({
    luals,
    '--check',
    root,
    '--configpath',
    luals_config(),
    '--checklevel',
    'Warning',
    '--logpath',
    vim.fn.tempname(),
  }, function(output)
    -- Drop the `\r`-redrawn progress bar; keep diagnostics and the summary.
    return (output:gsub('[^\r\n]*\r', ''))
  end),
}

os.exit(vim.tbl_contains(results, false) and 1 or 0)
