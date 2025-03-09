class Badge < ApplicationRecord
    has_one_attached :badge do |attachable|
        attachable.variant :thumb, resize_to_limit: [250, 250]
    end
end
