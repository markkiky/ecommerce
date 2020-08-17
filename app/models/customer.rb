class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  # class << self
  #   def from_omniauth(auth_hash)
  #     user = find_or_create_by(uid: auth_hash['uid'], provider: auth_hash['provider'])
  #     user.name = auth_hash['info']['name']
  #     user.location = auth_hash['info']['location']
  #     user.image_url = auth_hash['info']['image']
  #     user.url = auth_hash['info']['urls']['Twitter']
  #     user.save!
  #     user
  #   end
  # end

  # Auth function for google
  def self.from_omniauth(auth)
    where(email: auth.info.email).first_or_initialize do |user|
      user.first_name = auth.info.name
      user.email = auth.info.email
      user.password = SecureRandom.hex
    end
  end
end
