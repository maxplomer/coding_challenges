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

end
