class User < ApplicationRecord
  has_many :notes, dependent: :destroy
  has_many :vocabularies, through: :notes

  attr_encrypted :password, key: 'This is a key that is 256 bits!!'
  validates :email, presence: true, uniqueness: true

  before_save :lowercase_email, if: :email =~ /[A-Z]/

  def token
    JWT.encode(id.to_s, nil, 'none')
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  private

  def lowercase_email
    self.email = email.downcase
  end
end
