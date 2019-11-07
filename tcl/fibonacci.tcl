proc fib {n} {
  if {$n < 2} {
    return $n
  } else {
    return [expr [fib [expr $n - 2]] + [fib [expr $n - 1]]]
  }
}

puts [expr [fib 34]]
