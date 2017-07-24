require "rails_helper"

RSpec.describe UserInfoMailer, type: :mailer do
  describe "notify" do
    let(:user)  { create(:user) }
    let(:pdf) { CreatePdf.file(user) }
    let(:mail) { UserInfoMailer.notify(user, pdf.path) }

    it "renders the headers" do
      expect(mail.subject).to eq("User #{user.email} info")
      expect(mail.to).to eq(['development@taskwunder.com'])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
      expect(mail.attachments[0].content_type)
        .to match("application/pdf; filename=user_information.pdf")
    end
  end
end
