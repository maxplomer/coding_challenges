class Challenge < ActiveRecord::Base

  has_many(
    :input_results,
    class_name: "InputResult",
    foreign_key: :challenge_id,
    dependent: :destroy
  )

  has_many(
    :allowed_methods,
    class_name: "AllowedMethod",
    foreign_key: :challenge_id,
    dependent: :destroy
  )

  has_many(
    :solutions,
    class_name: "Solution",
    foreign_key: :challenge_id,
    dependent: :destroy
  )

  has_many(
    :pictures,
    class_name: "Picture",
    foreign_key: :challenge_id,
    dependent: :destroy
  )

  has_many(
    :skeleton_answers,
    class_name: "SkeletonAnswer",
    foreign_key: :challenge_id,
    dependent: :destroy
  )

  def number_submissions
    self.solutions.length
  end

  def percent_successful
    if number_submissions == 0
      100
    else
      truncate(( number_successful * 1.0 / number_submissions ) * 100)
    end
  end

  def get_method_skeleton(language)
    self.skeleton_answers.select{ |i| i.language == language }[0].method_skeleton
  end

  def ruby_method_skeleton
    get_method_skeleton("Ruby")
  end 

  def javascript_method_skeleton
    get_method_skeleton("JavaScript")
  end

  def sql_method_skeleton
    get_method_skeleton("SQL")
  end

  def get_answer(language)
    self.skeleton_answers.select{ |i| i.language == language }[0].answer
  end

  def ruby_answer
    get_answer("Ruby")
  end 

  def javascript_answer
    get_answer("JavaScript")
  end

  def sql_answer
    get_answer("SQL")
  end

  def ruby_input_results
    self.input_results.select{ |i| i.language == "Ruby" }
  end

  def javascript_input_results
    self.input_results.select{ |i| i.language == "JavaScript" }
  end

  def sql_result
    self.input_results[0].result
  end

  def can_solve_in?(language)
    self.skeleton_answers.select{ |i| i.language == language }.length > 0
  end

  def javascript_method_call
    result = self.javascript_answer.split("\n")[0]
    result.gsub!("function","")
    result.gsub!(" ","")
    result.gsub!("\r","")
    result.gsub!("{","")
    result += ";"
    result
  end

  private

  def truncate(x)
    (x * 100).floor / 100.0
  end

  def number_successful
    self.solutions.select{ |i| i.success }.length
  end

end
