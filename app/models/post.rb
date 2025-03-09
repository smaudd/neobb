class Post < ApplicationRecord
    has_rich_text :body
    belongs_to :topic
    belongs_to :user
    has_many :replies, dependent: :destroy
end
