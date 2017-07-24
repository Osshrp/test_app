require 'rails_helper'

RSpec.describe CreatePdfJob, type: :job do

  let(:user) { create(:user) }

  it 'sends user info' do
    expect(UserInfoMailer).to receive(:notify).and_call_original
    CreatePdfJob.perform_now(user)
  end
end
