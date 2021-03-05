class User < ApplicationRecord
  has_many :notes, dependent: :destroy
  has_many :vocabularies, through: :note

  attr_encrypted :password, key: 'This is a key that is 256 bits!!'
  validates :email, presence: true, uniqueness: true
end
