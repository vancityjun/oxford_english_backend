class Note < ApplicationRecord
  belongs_to :user
  belongs_to :vocabulary
  has_many :definitions, dependent: :destroy
end
