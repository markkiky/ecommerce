class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :categories
  has_many :colors
  has_many :sizes
  has_many :products
  has_many :orders
  has_many :homes
  has_one_attached :avatar

  after_commit :add_default_avatar, on: %i[create update]

  def avatar_thumbnail
    begin
      if avatar.attached?
        avatar.variant(resize: "150x150!").processed
      else
        "/default_profile.jpg"
      end
    rescue => exception
      "/default_profile.jpg"
    else
      avatar.variant(resize: "150x150!").processed
    end
  end

  private

  def add_default_avatar
    unless avatar.attached?
      avatar.attach(
        io: File.open(
          Rails.root.join(
            "app", "assets", "images", "default_profile.jpg"
          )
        ), filename: "default_profile.jpg",
        content_type: "image/jpg",
      )
    end
  end
end
