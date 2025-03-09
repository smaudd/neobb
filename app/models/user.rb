class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :bans, dependent: :destroy
  has_many :badges
  has_many :posts
  has_many :replies
  has_one_attached :avatar do |attachable|
    attachable.variant :thumb, resize_to_limit: [250, 250]
  end

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  validates :email_address, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 8 }

  ROLES = %w[member admin moderator].freeze

  validates :role, inclusion: { in: ROLES }
  
end
