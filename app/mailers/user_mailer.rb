class UserMailer < ActionMailer::Base
  default from: 'notifications@speciestracker.com'
 
  def welcome_email(user)
    @user = user
    @url  = 'http://speciestracker.uws.edu.au'
    mail(to: @user.email, subject: 'Welcome to Species Tracker')
  end
  
  def new_user_waiting_for_approval(user)
    mail(to: 'g.devine@uws.edu.au', subject: 'Species Tracker Registration Request')
  end
  
end
