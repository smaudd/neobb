class PersonalizationData < ApplicationRecord
  belongs_to :user
  has_rich_text :bio
  has_one_attached :background_image
  has_one_attached :avatar
end
