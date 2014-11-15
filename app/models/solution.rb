class Solution < ActiveRecord::Base

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


end
