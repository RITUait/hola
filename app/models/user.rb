class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :signatures
  has_many :contacts
  has_many :templates
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

end
