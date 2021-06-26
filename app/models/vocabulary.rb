class Vocabulary < ApplicationRecord
  has_many :notes
  has_many :users, through: :notes

  validate :validate_pos
  validates_uniqueness_of :word, scope: :pos

  POS = [
    'indefinite article',
    'ordinal number',
    'number',
    'determiner',
    'exclamation',
    'auxiliary verb',
    'linking verb',
    'pronoun',
    'conjunction',
    'infinitive marker',
    'definite article',
    'modal verb',
    'noun',
    'verb',
    'adjective',
    'adverb',
    'preposition',
    'article'
  ].freeze

  # temporary
  def definitions
    notes.map(&:definitions).flatten
  end

private

  def validate_pos
    errors.add(:pos, 'pos is invalid') unless POS.include? pos
  end
end
