class Reply < ApplicationRecord
    has_rich_text :body
    belongs_to :post
    belongs_to :user
end
