class BadjorasMailer < ApplicationMailer
  def badjoras(user)
    @user = user
    mail(to: @user, subject: 'Test')
  end
end