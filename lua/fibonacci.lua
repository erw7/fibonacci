function fibonacchi(num)
  if num < 2 then
    return num
  else
    return fibonacchi(num - 1) + fibonacchi(num - 2)
  end
end

local start_time = os.clock()
local fib = fibonacchi(34)
local end_time = os.clock()
print("elapsed time:", end_time - start_time)
print(fib)
