class User < ApplicationRecord
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: {case_sensitive: false}
  has_secure_password
  has_one_attached :picture do |attachable|
    attachable.variant :thumb, resize_to_fill: [200, 200]
  end
end
