class User < ActiveRecord::Base
  attr_reader :password
  validates :password_digest, :presence => true
  validates :password, :length => { :minimum => 6, :allow_nil => true }
  validates :session_token, :presence => true, :uniqueness => true
  validates :email, :presence => true, :uniqueness => true

  before_validation :ensure_session_token

  has_many(
    :follows,
    class_name: "Follow",
    foreign_key: :follower_id,
    dependent: :destroy
  )

  has_many(
    :users_they_follow,
    through: :follows,
    source: :leader
  )

  has_many(
    :solutions,
    class_name: "Solution",
    foreign_key: :user_id,
    dependent: :destroy
  )

  def follows?(user) 
    self.users_they_follow.include?(user)
  end

  def have_solved?(challenge, language)
    self.solutions.select{ |i| i.challenge == challenge && i.success && i.language == language }.length > 0 
  end

  def number_easy_submissions
    self.solutions.select{ |i| i.challenge.difficulty == "easy" && i.success}.length
  end

  def number_medium_submissions
    self.solutions.select{ |i| i.challenge.difficulty == "medium" && i.success}.length
  end

  def number_hard_submissions
    self.solutions.select{ |i| i.challenge.difficulty == "hard" && i.success}.length
  end

  def points
    number_easy_submissions + number_medium_submissions * 2 + number_hard_submissions
  end

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

  ### auth ###

  def self.find_by_credentials(email, password)
    user = User.find_by_email(email)
    user.try(:is_password?, password) ? user : nil
  end

  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def is_password?(unencrypted_password)
    BCrypt::Password.new(self.password_digest).is_password?(unencrypted_password)
  end

  def password=(unencrypted_password)
    if unencrypted_password.present?
      @password = unencrypted_password
      self.password_digest = BCrypt::Password.create(unencrypted_password)
    end
  end

  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save!
    self.session_token
  end

  private

  def truncate(x)
    (x * 100).floor / 100.0
  end

  def number_successful
    self.solutions.select{ |i| i.success }.length
  end

  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end  


end
