require "shikashi"

include Shikashi

s = Sandbox.new
priv = Privileges.new

priv.allow_method :upto
priv.allow_method :length
priv.allow_method :+
priv.allow_method :[]
priv.allow_method :*
priv.allow_method :-


solution = 'def dotproduct(x, y)
  total = 0
  0.upto(x.length - 1) { |i| total += x[i] * y[i] }
  total
end'

solution = 'class X
' + solution +'
end'

s.run(priv, solution)

sol = s.base_namespace::X.new
x = [1, 2, 3]
y = [10, 10, 10]
puts sol.dotproduct(x, y)
