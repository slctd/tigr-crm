require "spec_helper"

describe CrmMailer do
  describe "export" do
    let(:mail) { CrmMailer.export }

    it "renders the headers" do
      mail.subject.should eq("Export")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
