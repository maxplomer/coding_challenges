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

    eval_str = "sol." + get_method_call(challenge)

    b = binding
    b.eval input_results[1].input

    user_result = b.eval(eval_str)

    puts user_result

  end

  private

  def get_method_call(challenge)
    result = challenge.answer.split("\n")[0]
    result.gsub!("def","")
    result.gsub!(" ","")
    result
  end


end
