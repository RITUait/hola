require 'rails_helper'

RSpec.describe Signature, type: :model do
	subject { described_class.new }

  it "is valid with valid attributes" do
    subject.name = "Anything"
    subject.email = "(/@/)"
    subject.api_key = "Anything"
    subject.smtp_mail_server = "Anything"
    expect(subject).to be_valid
  end
  it "is valid not without a name" do
    expect(subject).to_not be_valid
  end

  it "is not valid without a email" do
    subject.email = "(/@/)"
    expect(subject).to_not be_valid
  end

  it 'sends an email' do
  end

end
