" Vim syntax file
" Language: JavaScript
" Maintainer: Claudio Fleiner <claudio@fleiner.com>
" Updaters: Scott Shattuck (ss) <ss@technicalpursuit.com>
" URL:  http://www.fleiner.com/vim/syntax/javascript.vim
" Changes: (ss) added keywords, reserved words, and other identifiers
"  (ss) repaired several quoting and grouping glitches
"  (ss) fixed regex parsing issue with multiple qualifiers [gi]
"  (ss) additional factoring of keywords, globals, and members
" Last Change: 2012 Oct 05
"   2013 Jun 12: adjusted javaScriptRegexpString (Kevin Locke)

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
" tuning parameters:
" unlet javaScript_fold

if !exists("main_syntax")
  if version < 600
    syntax clear
  elseif exists("b:current_syntax")
    finish
  endif
  let main_syntax = 'javascript'
elseif exists("b:current_syntax") && b:current_syntax == "javascript"
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

" Drop fold if it set but vim doesn't support it.
if version < 600 && exists("js_fold")
  unlet js_fold
endif


syn keyword jsCommentTodo TODO FIXME XXX TBD contained
syn match jsLineComment "\/\/.*" contains=@Spell,jsCommentTodo
syn match jsCommentSkip "^[ \t]*\*\($\|[ \t]\+\)"
syn region jsComment start="/\*" end="\*/" contains=@Spell,jsCommentTodo
syn match jsSpecial "\\\d\d\d\|\\."
syn region jsStringD start=+"+ skip=+\\\\\|\\"+ end=+"\|$+ contains=jsSpecial,@htmlPreproc
syn region jsStringS start=+'+ skip=+\\\\\|\\'+ end=+'\|$+ contains=jsSpecial,@htmlPreproc

syn match jsNumber "-\=\<\d\+\(e\d\+\)\=\>\|0[xX][0-9a-fA-F]\+\>"
syn region jsRegexpString start=+/[^/*]+me=e-1 skip=+\\\\\|\\/+ end=+/[gim]\{0,2\}\s*$+ end=+/[gim]\{0,2\}\s*[;.,)\]}]+me=e-1 contains=@htmlPreproc,jsSpecial oneline

if exists("g:javascript#equalhi") && g:javascript#equalhi == 1
  syn match jsOperator "\zs\(<\|>\|\^\|[><|^!+=\/\-*]=\|===\|=\|!==\)\ze" skipwhite nextgroup=jsStringS,jsSpecial
  syn match jsOperator "||\|&&\|[-+*~]\|[^\/]\zs\/\ze[^\/]" skipwhite nextgroup=jsStringS,jsSpecial
endif

syn keyword jsConditional if else switch
syn keyword jsRepeat while for
syn match jsRepeat "\zs\<\(do\|in\)\ze\>."
syn keyword jsBranch break continue
syn keyword jsOperator new delete instanceof typeof constructor
syn keyword jsType Array Boolean Date Math Function Number Object String RegExp Promise TreeWalker NodeIterator XMLHttpRequest
syn keyword jsStatement return with
syn keyword jsBoolean true false
syn keyword jsNull null undefined void
syn keyword jsIdentifier arguments var let
syn keyword jsLabel case default
syn keyword jsRequire require
syn keyword jsException try catch finally throw Error
syn keyword jsMessage alert confirm prompt status
syn keyword jsGlobal global window document console
syn match jsMethods "\.\zs\(addEventListener\|apply\|call\|bind\|\(clear\|set\)\(Interval\|Timeout\)\|\(offset\|inner\|scroll\|client\)\(Height\|Width\)\|getElementById\|getElementsBy\(ClassName\|TagName\(NS\)\=\|Name\)\)\ze\([^a-zA-Z_$]\|$\)"
syn keyword jsReference self top parent this
syn keyword jsMember location
syn keyword jsReserved class const debugger enum export extends import super

if exists("js_fold")
    syn match jsFunction "\<function\>"
    syn region jsFunctionFold start="\<function\>.*[^};]$" end="^\z1}.*$" transparent fold keepend

    syn sync match jsSync grouphere jsFunctionFold "\<function\>"
    syn sync match jsSync grouphere NONE "^}"

    setlocal foldmethod=syntax
    setlocal foldtext=getline(v:foldstart)
else
    syn keyword jsFunction function
    syn match jsBraces "[{}\[\]]"
    " syn match jsParens "[()]"
endif

syn sync fromstart
syn sync maxlines=100

if main_syntax == "javascript"
  syn sync ccomment jsComment
endif

hi def link jsComment Comment
hi def link jsLineComment Comment
hi def link jsCommentTodo Todo
hi def link jsSpecial Repeat
hi def link jsStringS String
hi def link jsStringD String
hi def link jsCharacter Character
hi def link jsConditional Conditional
hi def link jsRepeat Repeat
hi def link jsBranch Conditional
hi def link jsOperator Operator
hi def link jsMethods Special
hi def link jsType Type
hi def link jsStatement Statement
hi def link jsFunction Function
if exists("g:javascript#bracehi") && g:javascript#bracehi == 1
  hi def link jsBraces Delimiter
  hi def link jsParens Delimiter
endif
hi def link jsError Error
hi def link javaScrParenError jsError
hi def link jsNull Operator
hi def link jsBoolean Boolean
hi def link jsRegexpString String
hi def link jsRequire Include
hi def link jsIdentifier Identifier
hi def link jsLabel Label
hi def link jsNumber Number
hi def link jsException Exception
hi def link jsMessage Keyword
hi def link jsGlobal Keyword
hi def link jsReference Special
hi def link jsMember Keyword
hi def link jsDeprecated Exception
hi def link jsReserved Exception
hi def link jsDebug Debug
hi def link jsConstant Label

let b:current_syntax = "javascript"
if main_syntax == 'javascript'
  unlet main_syntax
endif
let &cpo = s:cpo_save
unlet s:cpo_save

" vim: ts=8
