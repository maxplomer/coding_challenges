class Solution < ActiveRecord::Base
  include Shikashi

  belongs_to(
    :challenge,
    class_name: "Challenge",
    foreign_key: :challenge_id
  )

  belongs_to(
    :user,
    class_name: "User",
    foreign_key: :user_id
  )

  def success?
    challenge = self.challenge
    input_results = challenge.input_results
    allowed_methods = challenge.allowed_methods

    s = Sandbox.new
    priv = Privileges.new

    allowed_methods.each do |allowed_method|
      priv.allow_method allowed_method.method.to_sym
    end

    solution = self.method_string

    solution = 'class X
    ' + solution +'
    end'

    s.run(priv, solution)

    sol = s.base_namespace::X.new

    eval(input_results[1].input)
    x = [1, 2, 3]
    y = [10, 10, 10]
    puts sol.dotproduct(x, y)

    puts input_results[1].input

  end

end
