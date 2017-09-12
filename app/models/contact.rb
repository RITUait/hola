class Contact < ApplicationRecord
  belongs_to :user
  acts_as_taggable_on :tags

  require 'csv'

  def self.import(file,user_id)
    #user = User.find_by(id: user_id)
   p @errors = []
   i = 0
    CSV.foreach(file.path, headers: true).with_index  do |row,i|
      i += 1
      p contact = Contact.find_or_create_by(email: row['email'], user_id: user_id)
      tags = CSV.parse_line(row['conference'], col_sep: ' ')
      if contact.persisted?
        p contact.tag_list.add(tags)
      #contact = find_by_tag_list_and_user_id(row["conference"], user)
        contact.save
      else
      user = User.find_by(id: user_id)
        contact = Contact.create(:name => row["name"], :email => row["email"], :company => row["company"], :tag_list => tags,:user_id => user_id)
        if contact.save
        
        else
          contact.errors.full_messages.each do |message|
         p @errors << "Issue line #{i}, column #{message}"
        end
      end
    end
  end
    @errors 
  end

  validates :email,:name,:company,:tag_list,presence: true
end


