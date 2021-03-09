class Definition < ApplicationRecord
  belongs_to :note, optional: true
  has_many :examples
end
