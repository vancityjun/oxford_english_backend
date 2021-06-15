class Vocabulary < ApplicationRecord
  has_many :notes
  has_many :users, through: :notes

  validate :validate_pos
  before_save :check_duplication

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

  def check_duplication
    vocabularies =  Vocabulary.where(word: word)
    errors.add(:word, "duplication: vocabulary #{word} is already exist") if Vocabulary.where(word: word).count > 1
  end
end
