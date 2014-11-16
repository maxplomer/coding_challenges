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

  def number_submissions
    self.solutions.length
  end

  def percent_successful
    ( number_successful / number_submissions ) * 100
  end

  private

  def number_successful
    self.solutions.collect{ |i| i.success }.length
  end

end
