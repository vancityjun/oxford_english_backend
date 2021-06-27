class Phrase < ApplicationRecord
  include WordLists
  validates_uniqueness_of :word
end
