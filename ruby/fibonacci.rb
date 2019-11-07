def f(n)
  if n < 2
    return n
  else
    return f(n-1) + f(n-2)
  end
end

require 'benchmark'
n = ($n || 34).to_i
Benchmark.bm(10) do |x|
  x.report(RUBY_VERSION) { printf("fibonacchi(34):%d\n", f(n)) }
end
