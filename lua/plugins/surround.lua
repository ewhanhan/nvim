-- === NVIM-SURROUND ===
--
-- ADD: ys{motion}{char}
--   ysiw"      word        →  "word"
--   ysiW'      wo.rd       →  'wo.rd'
--   ys$)       to end      →  (to end)
--   ys2w]      two words   →  [two words]
--   ysiwb      word        →  (word)         b = )
--   ysiwB      word        →  {word}         B = }
--   ysiwr      word        →  [word]         r = ]
--   ysiwa      word        →  <word>         a = >
--   ysiwf      word        →  func(word)     prompts for func name
--   ysiwt      word        →  <tag>word</tag> prompts for tag
--
-- DELETE: ds{char}
--   ds"        "word"      →  word
--   ds)        (expr)      →  expr
--   dst        <div>x</div> → x
--   dsf        func(x)     →  x
--   dsq        'word'      →  word           q = nearest quote
--
-- CHANGE: cs{old}{new}
--   cs"'       "word"      →  'word'
--   cs)]       (list)      →  [list]
--   cst<span>  <div>x</div> → <span>x</span>
--
-- VISUAL: S{char}
--   viw S"     word        →  "word"
--   vip S{     paragraph   →  { paragraph }
--   V S<div>   line        →  <div>line</div>
--
return {
  {
    'kylechui/nvim-surround',
    version = '*',
    opts = {},
  },
}
