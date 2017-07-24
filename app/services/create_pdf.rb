class CreatePdf
  def self.file(user)
    file = Tempfile.new([user.email, '.pdf'])

    Prawn::Document.generate(file) do
      text "User #{user.name} information:"
      %w(email name birth_date bio).each do |attr|
        text "#{attr.capitalize}: #{user.send(attr.to_sym)}"
      end
    end
    file.close
    file
  end
end
