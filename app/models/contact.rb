class Contact < ApplicationRecord

  acts_as_taggable_on :tags

  require 'csv'

  def self.import(file)

    CSV.foreach(file.path, headers: true) do |row|
      #Contact.create! row.to_hash 
      Contact.create!(:name => row["name"], :email => row["email"], :company => row["company"], :tag_list => [row["tag_list"]])
    end
  end


  validates :email,:name,:company, presence: true
end
