class Blog < ApplicationRecord
	before_save :sanitize_url_slug

	validates :name, :url_slug, presence: true
	has_many :posts, dependent: :destroy
	belongs_to :user
	has_attached_file :cover_image, styles: {medium: "200x200", large: "1140x296"}
	validates_attachment_content_type :cover_image,
									 :content_type => ["image/jpg", "image/jpeg", "image/png"]


	scope :find_by_slug, ->(slug) {find_by(url_slug: slug)}
	scope :posts_from_slug, ->(slug) {find_by(url_slug: slug).posts}
	scope :posts_from_slug_in_order, ->(slug) {find_by(url_slug: slug).posts.order('id desc')}


	def sanitize_url_slug
		self.url_slug.delete!("\s")
	end

end
