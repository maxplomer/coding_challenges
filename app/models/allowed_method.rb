class AllowedMethod < ActiveRecord::Base

  belongs_to(
    :challenge,
    class_name: "Challenge",
    foreign_key: :challenge_id
  )
	
end
