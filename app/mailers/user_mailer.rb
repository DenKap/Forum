class UserMailer < ApplicationMailer

	default from: 'admin@forumname.com'
 
  def reset_password(user)
    @user = user
    mail(to: @user.email, subject: 'Forumname - Reset password')
  end

end
