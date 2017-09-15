class Signature < ApplicationRecord
  belongs_to :user
  validates :name,:api_key,:smtp_mail_server, presence: true
  validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
end
