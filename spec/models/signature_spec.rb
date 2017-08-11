require 'rails_helper'

RSpec.describe Signature, type: :model do
	subject { described_class.new }

  it "is valid with valid attributes" do
    subject.name = "Anything"
    subject.email = "(/@/)"
    expect(subject).to be_valid
  end
  it "is valid without a name" do
    expect(subject).to_not be_valid
  end

  it "is not valid without a email" do
    subject.email = "(/@/)"
    expect(subject).to_not be_valid
  end

  it 'sends an email' do
  end

end
