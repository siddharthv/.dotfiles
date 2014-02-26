" Vim syntax file
" Language:         /var/log/SMlog file
" Maintainer:       Siddharth Vinothkumar <siddharth123v@gmail.com>
" Latest Revision:  2014-02-26

if exists("b:current_syntax")
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

syn match   messagesBegin       display '^' nextgroup=messagesDate,messagesDateRFC3339

syn match   messagesDate        contained display '\a\a\a [ 0-9]\d *'
                                \ nextgroup=messagesHour

syn match   messagesHour        contained display '\d\d:\d\d:\d\d\s*'
                                \ nextgroup=messagesHost

syn match   messagesHost        contained display '\S*\s*'
                                \ nextgroup=messagesLabel

syn match   messagesLabel       contained display '\s*[^:]*:\s*'
                                \ nextgroup=messagesPID contains=messageSM

syn match   messageSM           contained display 'SM:'

syn match   messagesPID         contained display '\[\zs\d\+\ze\]'
                                \ nextgroup=messagesText

syn match   messagesText        contained display '.*'
                                \ contains=messagesNumber,messagesIP,messagesURL,messagesError,smlogpreadSUCCESS,smlogLock

syn match   messagesIP          '\d\+\.\d\+\.\d\+\.\d\+'

syn match   messagesURL         '\w\+://\S\+'

syn match   smlogpreadSUCCESS   /pread SUCCESS/ display

syn match   smlogLock           /lock: .\+$/ display

syn match   messagesNumber      contained '0x[0-9a-fA-F]*\|\[<[0-9a-f]\+>\]\|\<\d[0-9a-fA-F]*'

syn match   messagesError       contained '\c.*\<\(FATAL\|ERROR\|ERRORS\|FAILED\|FAILURE\).*'

" Highlight any quoted strings
syntax region smlogString start=/"/ end=/"/ display oneline
syntax region smlogSingleString start=/'/ end=/'/ display oneline
highlight link smlogString String
highlight link smlogSingleString String

hi def link messagesDate        Constant
hi def link messagesHour        Type
hi def link messagesHost        Identifier
hi def link messagesLabel       Operator
hi def link messageSM           String
hi def link messagesPID         Constant
hi def link messagesKernel      Special
hi def link messagesError       ErrorMsg
hi def link messagesIP          Constant
hi def link messagesURL         Underlined
hi def link messagesText        Normal
hi def link messagesNumber      Number
hi def link smlogpreadSUCCESS   Normal
hi def link smlogLock           Comment

let b:current_syntax = "smlog-exp"

let &cpo = s:cpo_save
unlet s:cpo_save
