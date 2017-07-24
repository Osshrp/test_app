require 'rails_helper'

RSpec.describe CreatePdf do
  let(:user) { create(:user) }

  it '.file' do
    file = CreatePdf.file(user)
    expect(Pathname.new(file).basename.to_s).to match(/#{user.email}/)
  end
end
