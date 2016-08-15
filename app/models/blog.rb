class Blog < ApplicationRecord
	before_save :sanitize_url_slug

	validates :name, :url_slug, presence: true
	has_many :posts, dependent: :destroy
	belongs_to :user
	has_attached_file :cover_image, styles: {medium: "200x200", large: "1140x296"}
	validates_attachment_content_type :cover_image,
									 :content_type => ["image/jpg", "image/jpeg", "image/png"]


	scope :find_by_slug, ->(slug) {find_by(url_slug: slug)}


	def sanitize_url_slug
		self.url_slug.gsub!(/[^a-zA-Z0-9\-]/,"")
	end

end
