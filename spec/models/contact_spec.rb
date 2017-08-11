require 'rails_helper'

RSpec.describe Contact, type: :model do
	
	
    #CSV.open(@file_name, headers: true) do |row|
      #Contact.create(:name => "abc", :email => "aj@gm.com", :company => "cAB", :tag_list => "tag_list")
   #end
   describe "self.import(file)" do 
    it "can upload a CSV file" do
      @file_name = File.open("/home/pravin/contact.csv")
      p @file_name
      Contact.import(@file_name)
    end
	end
  subject { described_class.new }
	it "is valid with valid attributes" do
		subject.name = "Anything"
    	subject.email = "(/@/)"
    	subject.company= "Anything"
    	expect(subject).to be_valid
    end
  	it "is not valid without a name" do
  		subject.name = ""
    	expect(subject).to_not be_valid
  	end

  	it "is not valid without a email" do
    	subject.email = "(/@/)"
    	expect(subject).to_not be_valid
  	end
end
