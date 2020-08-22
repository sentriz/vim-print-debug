if exists("g:loaded_print_debug")
    finish
endif

let g:loaded_print_debug = 1

if !exists("g:print_debug_default")
    let g:print_debug_default = '"{}"'
endif

if !exists("g:print_debug_templates")
    let g:print_debug_templates = {
    \   'go':         'fmt.Printf("+++ {}\n")',
    \   'python':     'print(f"+++ {}")',
    \   'javascript': 'console.log(`+++ {}`);',
    \   'c':          'printf("+++ {}\n");',
    \ }
endif

function! print_debug#print_debug()
    let t:print_debug_current_nr = get(t:, 'print_debug_current_nr', 96)
    let t:print_debug_current_nr += 1

    let l:char_str = repeat(nr2char(t:print_debug_current_nr), 10)
    let l:line_template = get(g:print_debug_templates, &filetype, g:print_debug_default)
    let t:print_debug_line = substitute(l:line_template, '{}', l:char_str, '')
    silent execute "normal! o\<C-r>\<C-r>=t:print_debug_line\<CR>\<Esc>"
endfunction
