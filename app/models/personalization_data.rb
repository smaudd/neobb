class PersonalizationData < ApplicationRecord
  belongs_to :user
  has_rich_text :bio
  has_one_attached :avatar do |attachable|
    attachable.variant :thumb, resize_to_limit: [250, 250]
  end
  has_one_attached :background_image do |attachable|
    attachable.variant :thumb, resize_to_limit: [1200, 1200]
  end
end
