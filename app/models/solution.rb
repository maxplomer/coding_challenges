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

  def sql_success?
    challenge = self.challenge
    result = eval(challenge.sql_result)

    @connection = ActiveRecord::Base.establish_connection(
                :adapter => "postgresql",
                :host => "ec2-23-23-210-37.compute-1.amazonaws.com",
                :database => "d75thet6sa5c0l",
                :username => ENV["SQL_CHALLENGES_DATABASE_USERNAME"],
                :password => ENV["SQL_CHALLENGES_DATABASE_PASSWORD"]
    )
    sql = self.method_string.dup
    sql.gsub!("\n"," ")
    sql.gsub!("\r"," ")

    #sandbox - start
    sql_upcase = sql.upcase
    ["INSERT", "DELETE", "UPDATE", "MERGE", "TRUNCATE"].each do |bad_command|
      return false if sql_upcase.include?(bad_command)
    end
    #sandbox - end

    my_result = @connection.connection.execute(sql);
    all_true = []
    result.each_index{|i| all_true << (result[i] == my_result[i])}

    all_true.all?
  end

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
