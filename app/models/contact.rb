class Contact < ApplicationRecord
  belongs_to :user
  acts_as_taggable_on :tags


  def self.import(file,user_id)
    #user = User.find_by(id: user_id)
    @errors = []
    CSV.foreach(file.path, headers: true).with_index  do |row,i|
      i += 1
      contact = Contact.find_or_create_by(email: row['email'], user_id: user_id)
      tags = CSV.parse_line(row['conference'], col_sep: ' ')
      if contact.persisted?
        contact.tag_list.add(tags)
        #contact = find_by_tag_list_and_user_id(row["conference"], user)
        contact.save
      else
        contact = Contact.create(:name => row["name"], :email => row["email"], :company => row["company"], :tag_list => [row["conference"]],user_id: user_id)
        contact.save
          contact.errors.full_messages.each do |message|
            row = [row["name"], row["email"], row["company"], row["conference"], message]
            @errors << row
        end
      end
    end

    if @errors.present?
      attributes = %w{Name Email Company Conference}
      CSV.open(Rails.root.join('public', "file.csv"),"wb") do |csv|
        csv << attributes
        @errors.each do |message|
          csv << message 
        end

      end

    end
  end
  validates :name,:company,:tag_list,presence: true
  validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
end


