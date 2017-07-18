class Contact < ApplicationRecord
  acts_as_taggable
  acts_as_taggable_on :rise, :deccan
end
