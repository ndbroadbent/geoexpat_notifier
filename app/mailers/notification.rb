class Notification < ActionMailer::Base

  helper :application

  default :from => "nathan.f77@gmail.com"

  def notification_email(user, filter, classified)
    @user = user
    @filter = filter
    @classified = classified
    mail(:to => user.email,
         :subject => "GeoExpat Classified Notification")
  end
end

