class Signature < ApplicationRecord
  belongs_to :user
  validates :name,:api_key,:smtp_mail_server, presence: true
  validates_uniqueness_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/,:message => '%{value} has already been taken'
end
