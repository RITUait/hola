class Signature < ApplicationRecord
  belongs_to :user
  validates :name,:api_key,:smtp_mail_server, presence: true
  validates :email, format: { with: /@/ }
end
