class Signature < ApplicationRecord
	validates :name, presence: true
	validates :email, format: { with: /@/ }
end
