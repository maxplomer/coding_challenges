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
    input_results = challenge.ruby_input_results
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

    input_results.each do |input_result|
      input = input_result.input
      result = input_result.result

      b = binding
      b.eval input

      user_result = b.eval(eval_str)

      if user_result != eval(result)
        return false
      end
    end
    
    true
  end

  private

  def get_method_call(challenge)
    result = challenge.ruby_answer.split("\n")[0]
    result.gsub!("def","")
    result.gsub!(" ","")
    result
  end

end
