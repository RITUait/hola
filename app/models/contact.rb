class Contact < ApplicationRecord
  belongs_to :user
  acts_as_taggable_on :tags

  require 'csv'

  def self.import(file,user_id)
    user = User.find_by(id: user_id)

    CSV.foreach(file.path, headers: true) do |row|
      #Contact.create! row.to_hash 
      user.contacts.create!(:name => row["name"], :email => row["email"], :company => row["company"], :tag_list => [row["conference"]])
    end
  end


  validates :email,:name,:company,:tag_list,presence: true
end
