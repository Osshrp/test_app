class CreatePdfJob < ApplicationJob
  queue_as :default

  def perform(user)
    file = pdf_file(user)
    # UserInfoMailer.notify(user, file).deliver_later(wait: 1.minute)
    UserInfoMailer.notify(user, file)
  end

  def pdf_file(user)
    file = Tempfile.new([user.email, '.pdf'])

    Prawn::Document.generate(file) do
      text 'User information:'
      %w(email name birth_date bio).each do |attr|
        text "#{attr.capitalize}: #{user.send(attr.to_sym)}"
      end
    end
    file
  end
end
