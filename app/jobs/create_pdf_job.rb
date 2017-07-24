class CreatePdfJob < ApplicationJob
  queue_as :default

  def perform(user)
    UserInfoMailer.notify(user, CreatePdf.file(user).path).deliver_later(wait: 1.minute)
  end
end
