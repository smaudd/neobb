class Post < ApplicationRecord
    has_rich_text :body
    belongs_to :topic
    belongs_to :user
    has_many :replies, dependent: :destroy

    validates :slug, uniqueness: true, presence: true

    def to_param
      slug
    end
  
    private
  
    def generate_slug
      return if slug.present? # Avoid overwriting manually set slugs
  
      base_slug = title.parameterize
      slug_candidate = base_slug
      count = 2
  
      # Ensure uniqueness
      while Post.exists?(slug: slug_candidate)
        slug_candidate = "#{base_slug}-#{count}"
        count += 1
      end
  
      self.slug = slug_candidate
    end
end
