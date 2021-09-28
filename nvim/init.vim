lua require'impatient'.enable_profile()
lua require'lewis6991'
lua require'packer_compiled'

" Filetype detections
augroup vimrc
    autocmd BufRead dotshrc,dotsh         setlocal filetype=sh
    autocmd BufRead dotcshrc              setlocal filetype=csh
    autocmd BufRead *.tmux                setlocal filetype=tmux
    autocmd BufRead *.jelly               setlocal filetype=xml
    autocmd BufRead setup.cfg             setlocal filetype=dosini
    autocmd BufRead gerrit_hooks          setlocal filetype=dosini
    autocmd BufRead requirements*.txt     setlocal filetype=requirements
    autocmd BufRead lit.cfg,lit.local.cfg setlocal filetype=python
    autocmd BufRead gitconfig             setlocal filetype=gitconfig
    autocmd BufRead * if getline(1) =~ '^#%Module.*'
                  \ |     setlocal ft=tcl
                  \ | endif
    autocmd BufRead modulefile            setlocal filetype=tcl
augroup END

" Filetype settings

augroup vimrc
    autocmd Filetype tags          setlocal tabstop=30
    autocmd Filetype gitconfig     setlocal noexpandtab
    autocmd Filetype log           setlocal textwidth=1000
    autocmd FileType xml           setlocal foldnestmax=20
    autocmd Filetype fugitiveblame setlocal cursorline
augroup END

iabbrev :rev:
    \ <c-r>=printf(&commentstring,
    \     ' REVISIT '.$USER.' ('.strftime("%d/%m/%y").'):')<CR>
