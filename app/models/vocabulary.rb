class Vocabulary < ApplicationRecord
  has_many :definitions, dependent: :destroy
end
