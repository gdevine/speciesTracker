class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  before_save { self.email = email.downcase }
  
  after_create :send_admin_mail, :send_welcome_mail
  
  # Set out different user roles available
  def self.roles
    ['user', 'superuser', 'admin']
  end
         
  validates :firstname, presence: true, length: { maximum: 30 }
  validates :surname, presence: true, length: { maximum: 30 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 80 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  
  validates_inclusion_of :role, in: self.roles
  validate :name_has_no_numbers
  
  ## Custom validations
  def name_has_no_numbers
    errors.add(:base, "First Name or Surname can not contain numbers") if
      /\d/.match( self.firstname ) || /\d/.match( self.surname )
  end
  
  # Devise 'approved' settings
  def active_for_authentication? 
    super && approved? 
  end 

  def inactive_message 
    if !approved? 
      :not_approved 
    else 
      super # Use whatever other message 
    end 
  end
  
  def send_admin_mail
    UserMailer.new_user_waiting_for_approval(self).deliver_now
  end
  
  def send_welcome_mail
    UserMailer.welcome_email(self).deliver_now
  end
  
  def fullname
    self.firstname << " " << self.surname
  end
  
  
end
