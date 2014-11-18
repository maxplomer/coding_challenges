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

  private

  def truncate(x)
    (x * 100).floor / 100.0
  end

  def number_successful
    self.solutions.select{ |i| i.success }.length
  end

end
