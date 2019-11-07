" $vim -u fib.vim -U NONE -i NONE -c "quit" --noplugin

let s:is_debug = 1
" let s:is_debug = 0
" Interpreter initialization.
if has('tcl')
lua << EOF
EOF
endif
if has('perl')
perl << EOF
EOF
endif
if has('python')
python << EOF
EOF
endif
if has('python3')
python3 << EOF
EOF
endif
if has('ruby')
ruby << EOF
EOF
endif
if has('tcl')
tcl << EOF
EOF
endif

function! Fib2(n)
  if a:n < 2
    return a:n
  else
    return Fib2(a:n-1) + Fib2(a:n-2)
  endif
endfunction

function! Fib(n)
  echomsg 'n = ' . a:n
  let start = reltime()
  if s:is_debug
    echo Fib2(a:n)
  else
    call Fib2(a:n)
  endif
  echomsg 'Vim        = ' . reltimestr(reltime(start))

if has('nvim')
lua << EOF
vim.eval = vim.api.nvim_eval
EOF
endif
if has('lua') || has('nvim')
  let start = reltime()
lua << EOF
function fib(n)
  if n < 2 then
    return n
  end
  return fib(n-2) + fib(n-1)
end
if vim.eval('s:is_debug') == 1 then
  print(fib(tonumber(vim.eval('a:n'))))
else
  fib(tonumber(vim.eval('a:n')))
end
EOF
  echomsg 'if_lua     = ' . reltimestr(reltime(start))
endif

if has('python')
  let start = reltime()
python << EOF
import vim
def fib(n):
  if n < 2:
    return n
  else :
    return fib(n-2) + fib(n-1)
if vim.eval('s:is_debug') == "1":
  print(fib(int(vim.eval('a:n'))))
else :
  fib(int(vim.eval('a:n')))
EOF
  echomsg 'if_python  = ' . reltimestr(reltime(start))
endif

if has('python3')
  let start = reltime()
python3 <<EOF
import vim
def fib(n):
  if n < 2:
    return n
  else :
    return fib(n-2) + fib(n-1)
if vim.eval('s:is_debug') == "1":
  print(fib(int(vim.eval('a:n'))))
else :
  fib(int(vim.eval('a:n')))
EOF
  echomsg 'if_python3 = ' . reltimestr(reltime(start))
endif

if has('ruby')
  let start = reltime()
ruby << EOF
def fib n
  return n if n < 2
  fib(n-2) + fib(n-1)
end

if VIM::evaluate('s:is_debug').to_i == 1 then
  print fib(VIM::evaluate('a:n').to_i)
else
  fib(VIM::evaluate('a:n').to_i)
end
EOF
  echomsg 'if_ruby    = ' . reltimestr(reltime(start))
endif

if has('perl')
  let start = reltime()
perl << EOF
sub fib {
  my ($n) = @_;
  if ($n < 2) {
    return $n;
  } else {
    return &fib($n - 2) + &fib($n - 1);
  }
}

my $n = VIM::Eval('a:n');
if (VIM::Eval('s:is_debug') eq "1"){
  VIM::Msg(&fib($n));
} else {
  &fib($n);
}
EOF
  echomsg 'if_perl    = ' . reltimestr(reltime(start))
endif

if has('tcl')
  let start = reltime()
tcl << EOF
proc fib {n} {
  if {$n < 2} {
    return $n
  } else {
    return [expr [fib [expr $n - 2]] + [fib [expr $n - 1]]]
  }
}
if {[::vim::expr s:is_debug] == "1"} {
  puts [fib [::vim::expr a:n]]
} else {
  fib [::vim::expr a:n]
}
puts ""
EOF
  echomsg 'if_tcl     = ' . reltimestr(reltime(start))
endif
endfunction

for n in [5, 10, 15, 20, 25, 30]
  call Fib(n)
endfor
