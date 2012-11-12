runtime! syntax/ruby.vim
unlet b:current_syntax

syntax keyword rspecKeywords context describe it its let subject pending before scenario feature background
highlight link rspecKeywords rubyDefine

syntax keyword rspecMatchers should should_not expect
highlight link rspecMatchers rubyFunction

let b:current_syntax = "rspec"