require "rails_helper"

RSpec.describe NoticeMailer, type: :mailer do
  describe "new_message" do
    let(:room) { FactoryBot.create(:room) }
    let(:mail) { NoticeMailer.with({message_from: 'from@example.com', room: room, message_to: 'to@example.org'}).new_message }

    it "renders the headers" do
      expect(mail.subject).to eq("New message")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("You got a message from")
    end
  end
end
