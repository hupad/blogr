class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :blogs


  def gravatar size
  	gravatar_hash = Digest::MD5.hexdigest(self.email.downcase)
  	"https://www.gravatar.com/avatar/#{gravatar_hash}.jpg?s=#{size}"
  end

end
