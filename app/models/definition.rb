class Definition < ApplicationRecord
  belongs_to :note
  has_many :examples
end
