class UserInfoMailer < ApplicationMailer
  def notify(user, file_name)
    attachments['user_information.pdf'] = File.read(file_name)
    mail(to: 'development@taskwunder.com', subject: "User #{user.email} info")
  end
end
