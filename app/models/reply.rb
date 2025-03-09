require_relative '../validators/no_attachment_validator.rb'

class Reply < ApplicationRecord

    has_rich_text :body
    belongs_to :post
    belongs_to :user
        
    validates :body, presence: true
    validates :post_id, presence: true
    
    
end
