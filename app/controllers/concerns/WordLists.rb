module WordLists
  extend ActiveSupport::Concern

  included do
    has_many :notes
    has_many :users, through: :notes
  end

  # temporary
  def definitions
    notes.map(&:definitions).flatten
  end
end