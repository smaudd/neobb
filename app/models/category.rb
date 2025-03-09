class Category < ApplicationRecord
  has_many :topics
  has_one_attached :icon do |attachable|
    attachable.variant :thumb, resize_to_limit: [250, 250]
  end
end
