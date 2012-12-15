" Vim color file -- based on the nuvola theme, by J. Pfefferl

" Intro
set background=light
hi clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "autumnriver"

" Normal
hi Normal ctermfg=235 guifg=#222222 guibg=#fdfdfd ctermbg=15

" Search
hi IncSearch cterm=UNDERLINE ctermfg=237 gui=UNDERLINE guifg=#222222 guibg=#FFE568 ctermbg=221
hi Search cterm=UNDERLINE ctermfg=237 gui=NONE guifg=#222222 guibg=#FFE568 ctermbg=221

" Messages
hi ErrorMsg gui=BOLD guifg=#EB1513 ctermfg=9 guibg=NONE
hi! link WarningMsg ErrorMsg
hi ModeMsg gui=BOLD guifg=#0070ff ctermfg=27 guibg=NONE
hi MoreMsg guibg=NONE guifg=seagreen
hi! link Question MoreMsg

" Split area
hi StatusLine cterm=NONE ctermfg=58 gui=BOLD guibg=#56A0EE ctermbg=75 guifg=white
hi StatusLineNC gui=NONE guibg=#56A0EE ctermbg=75 guifg=#E9E9F4 ctermfg=244
hi! link VertSplit StatusLineNC
hi WildMenu gui=UNDERLINE guifg=#56A0EE ctermfg=75 guibg=#E9E9F4 ctermbg=7

" Diff
hi DiffText   gui=NONE guifg=#f83010 ctermfg=202 guibg=#ffeae0 ctermbg=229
hi DiffChange gui=NONE guifg=#006800 ctermfg=22 guibg=#d0ffd0 ctermbg=229
hi DiffDelete gui=NONE guifg=#2020ff ctermfg=21 guibg=#c8f2ea ctermbg=223
hi DiffAdd gui=NONE guifg=#2020ff ctermfg=21 guibg=#c8f2ea ctermbg=194

" Git styles
hi diffAdded guifg=#008f00 ctermfg=28
hi diffRemoved guifg=#bf0000 ctermfg=124
hi link gitcommitSelectedType diffAdded
hi link gitcommitSelectedFile gitcommitSelectedType
hi link gitcommitUnmergedType diffRemoved
hi link gitcommitUnmergedFile gitcommitUnmergedType
hi link gitcommitDiscardedType diffRemoved
hi link gitcommitDiscardedFile gitcommitDiscardedType
hi gitcommitUntrackedFile guifg=#6E79F1 guibg=#FFFFFF ctermfg=69 ctermbg=15

" Cursor
hi Cursor       gui=none guifg=#fdfdfd guibg=#f29222
"hi lCursor      gui=NONE guifg=#f8f8f8 ctermfg=15 guibg=#8000ff ctermbg=93
hi CursorIM     gui=NONE guifg=#f8f8f8 ctermfg=15 guibg=#8000ff ctermbg=93

" Fold
hi Folded gui=NONE guibg=#B5EEB5 ctermbg=157 guifg=#222222
hi! link FoldColumn Folded

" Other
hi Directory    gui=NONE guifg=#0000ff ctermfg=21 guibg=NONE
hi LineNr       gui=NONE guifg=#8080a0 ctermfg=103 guibg=NONE
hi NonText      gui=BOLD guifg=#4000ff ctermfg=57 guibg=#f0f0f0 ctermbg=255
hi Title        gui=BOLD guifg=#1014AD ctermfg=19 guibg=NONE
hi Visual gui=NONE guibg=#ffff95 ctermbg=229
hi VisualNOS ctermfg=yellow gui=UNDERLINE guifg=#222222 guibg=#BDDFFF ctermbg=153

" Syntax group
hi Comment guifg=#3F6B5B ctermfg=240
hi Constant guifg=#B91F49 ctermfg=125
hi Error ctermfg=15 ctermbg=9 guibg=Red guifg=White
hi Identifier ctermfg=Blue guifg=Blue
hi Number   gui=NONE guifg=#008c15 ctermfg=2
hi PreProc guifg=#1071CE ctermfg=26
hi Special ctermfg=darkmagenta guifg=red2
hi Statement gui=NONE guifg=#F04F00 ctermfg=202
hi Tag guifg=#af5f00 ctermfg=130
hi Todo ctermbg=Yellow ctermfg=blue guifg=Blue guibg=Yellow
hi Type ctermfg=Blue gui=NONE guifg=#2222fa
hi String guifg=#005f00 ctermfg=22
hi! link Character	String
hi! link Boolean	Constant
hi! link Float		Number
hi! link Function	Identifier
hi! link Conditional	Statement
hi! link Repeat	Statement
hi! link Label		Statemengreen
hi! link Operator	Statement
hi! link Keyword	Statement
hi! link Exception	Statement
hi! link Include	PreProc
hi! link Define	PreProc
hi! link Macro		PreProc
hi! link PreCondit	PreProc
hi! link StorageClass	Type
hi! link Structure	Type
hi! link Typedef	Type
hi! link SpecialChar	Special
hi! link Delimiter	Special
hi! link SpecialComment Special
hi! link Debug		Special

" Ruby styles
hi! rubyConstant guifg=#cA1909 ctermfg=160
hi! link railsClass rubyConstant
hi! rubyInstanceVariable guifg=#aa00ef ctermfg=129
hi! link rubyGlobalVariable rubyInstanceVariable
hi! link rubyDefine Keyword
hi! link rubySymbol PreProc
hi! link rubyBlockParameter Normal
hi! link rubyStringDelimiter String
hi! link rubyFunction Tag
hi! link rubyRailsMethod rubyFunction
hi! link rspecKeywords rubyDefine
hi! link rspecMatchers rubyFunction

" HTML
hi htmlLink                 gui=UNDERLINE guifg=#0000ff ctermfg=21 guibg=NONE
hi htmlBold                 gui=BOLD
hi htmlBoldItalic           gui=BOLD,ITALIC
hi htmlBoldUnderline        gui=BOLD,UNDERLINE
hi htmlBoldUnderlineItalic  gui=BOLD,UNDERLINE,ITALIC
hi htmlItalic               gui=ITALIC
hi htmlUnderline            gui=UNDERLINE
hi htmlUnderlineItalic      gui=UNDERLINE,ITALIC

" Autocomplete menu
hi Pmenu ctermbg=153 guibg=#afd7ff

" Trailing whitespace
hi TrailingWhitespace ctermbg=red guibg=red