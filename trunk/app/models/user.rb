class User < ActiveRecord::Base
  GenderMale, GenderFemale = 1, 2
  attr_accessor :password
  has_one :experience, :dependent => :destroy
  validates_confirmation_of :password

  def before_create
    self.hashed_password = Digest::MD5.hexdigest(self.password)
    self.level = 1
    self.experience = Experience.new
  end
  
  class << self
    def signin email, password, ip
      returning User.find_by_email_and_hashed_password(email, Digest::MD5.hexdigest(password)) do |user|
        unless user.blank?
          user.last_logined_at = Time.now
          user.last_logined_from = ip
          user.save
        end
      end
    end
  end
end
