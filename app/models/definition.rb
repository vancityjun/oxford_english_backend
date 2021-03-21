class Definition < ApplicationRecord
  belongs_to :note, optional: true
  has_many :examples, dependent: :destroy
  accepts_nested_attributes_for :examples, allow_destroy: true
end
