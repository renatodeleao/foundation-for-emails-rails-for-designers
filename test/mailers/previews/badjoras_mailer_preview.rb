# Preview all emails at http://localhost:3000/rails/mailers/
class BadjorasrMailerPreview < ActionMailer::Preview
  def badjoras
    BadjorasMailer.badjoras('Test Name')
  end
end