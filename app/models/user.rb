class User < ActiveRecord::Base
  has_secure_password 
  before_save :format_email

  def format_email
    self.email = self.email.delete(' ').downcase
  end
  
  def self.authenticate_with_credentials (email, password)
    @user = User.find_by(email: email)
    if @user && @user.authenticate(password)
    return @user
    else
     return nil
    end
  end

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates_uniqueness_of :email, case_sensitive: false
  validates :password, presence: true
  validates :password_confirmation, presence: true
def params
end
end
