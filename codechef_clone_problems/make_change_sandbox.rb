require "shikashi"

include Shikashi

s = Sandbox.new
priv = Privileges.new

priv.allow_method :each
priv.allow_method :>
priv.allow_method :<
priv.allow_method :+
priv.allow_method :[]
priv.allow_method :*
priv.allow_method :-
priv.allow_method :==
priv.allow_method :size

solution = 'def make_change(n, coins)
  @best = [1] * n

  make_change_work(n, coins, [])

  @best
end


def make_change_work(n, coins, change)
  if n == 0
    if change.size < @best.size
      @best = change
    end
    return
  end
  coins.each do |coin|
    next if coin > n
    make_change_work(n - coin, coins, change + [coin])
  end

  nil
end'

solution = 'class X
' + solution +'
end'

s.run(priv, solution)

sol = s.base_namespace::X.new
n = 14
coins = [10, 7, 1]
puts sol.make_change(n, coins)
