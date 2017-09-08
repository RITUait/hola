class Contact < ApplicationRecord
  belongs_to :user
  acts_as_taggable_on :tags

  require 'csv'

  def self.import(file,user_id)
    #user = User.find_by(id: user_id)
    CSV.foreach(file.path, headers: true) do |row|
      #Contact.create! row.to_hash 
     p contact = Contact.find_or_create_by(email: row['email'], user_id: user_id)
     tags = CSV.parse_line(row['conference'], col_sep: ' ')

     if contact.persisted?

        p contact.tag_list.add(tags)
      #contact = find_by_tag_list_and_user_id(row["conference"], user)
        contact.save
    else
      user = User.find_by(id: user_id)
    Contact.create!(:name => row["name"], :email => row["email"], :company => row["company"], :tag_list => tags, user_id: user_id)
    end
  end
  end
  def find_by_tag_list_and_user_id
   p Contact.find(:taglist => [row["conference"],user])
  end


  validates :email,:name,:company,:tag_list,presence: true
end


