class Vocabulary < ApplicationRecord
  has_many :notes
  has_many :users, through: :notes

  def definitions
    notes.map(&:definitions)
  end
end
