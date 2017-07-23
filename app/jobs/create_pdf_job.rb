class CreatePdfJob < ApplicationJob
  queue_as :default

  def perform(user)
    # UserInfoMailer.notify(user, file).deliver_later(wait: 1.minute)
    UserInfoMailer.notify(user, pdf_file(user)).deliver_now
  end

  def pdf_file(user)
    file = Tempfile.new([user.email, '.pdf'])

    Prawn::Document.generate(file) do
      text "User #{user.name} information:"
      %w(email name birth_date bio).each do |attr|
        text "#{attr.capitalize}: #{user.send(attr.to_sym)}"
      end
    end
    file.close
    file.path
  end
end
