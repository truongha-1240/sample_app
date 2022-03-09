class User < ApplicationRecord
  before_save :downcase_email
  validates :name, presence: true,
            length: {maximum: Settings.valid.length_50}
  validates :email, presence: true,
            length: {maximum: Settings.valid.length_255},
            format: {with: Settings.valid.email_regex},
            uniqueness: true
  validates :password, presence: true,
            length: {minimum: Settings.valid.length_6}
  has_secure_password

  private

  def downcase_email
    email.downcase!
  end
end
