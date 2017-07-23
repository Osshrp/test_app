class UserInfoMailer < ApplicationMailer
  def notify(user, file)
    attachments['user_information.pdf'] = file
    # mail(to: 'development@taskwunder.com​', subject: "User #{@user.email} info")
    mail(to: 'oss@bobrptd.ru​', subject: "User #{@user.email} info")
  end
end
