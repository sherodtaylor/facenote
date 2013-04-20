class Usercreated < ActionMailer::Base
  default from: "sherodtaylor@gmail.com"
  def welcome_email
    @email = User.last.email
    @name = User.last.name
    mail(:to => @email, :subject => "Welcome #{@name}")
  end
end
