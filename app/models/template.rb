class Template < ApplicationRecord
  belongs_to :user
  validates :description, presence: true
  validates_uniqueness_of :title,:message => '%{value} has already been taken'
end
