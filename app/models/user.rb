class User < ApplicationRecord

  before_create :generate_api_key

  validates :email, presence: true, uniqueness: true
  validates :password, confirmation: true
  validates :password_confirmation, presence: true

  has_secure_password

  private

  def generate_api_key
      self.api_key = SecureRandom.base64.tr('+/=', 'Qat')
  end
end
