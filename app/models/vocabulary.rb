class Vocabulary < ApplicationRecord
  has_many :notes
  has_many :users, through: :notes

  # temporary
  def definitions
    notes.map(&:definitions).flatten
  end
end
