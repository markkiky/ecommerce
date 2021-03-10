class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :trackable,
         :recoverable, :rememberable, :validatable
  #  :omniauthable, omniauth_providers: [:facebook, :google_oauth2, :twitter]
  after_commit :add_default_avatar, on: %i[update]

  has_many :orders
  has_many :wishlists
  has_many :reviews
  has_many :cars
  has_many :billing_addresses
  has_many :shipping_addresses
  has_one_attached :avatar

  validates :first_name, :presence => true
  validates :last_name, :presence => true

  
  def self.counter
    @customers = Customer.all
    prefix = "UAE"
    if @customers.count < 1
        count = "1"
        customer_no = "#{prefix}##{count.rjust(3,"0")}"
        return customer_no
    else
        last = Customer.last
        if last.customer_no != nil
            count = last.customer_no.split(//).last(3).join.to_i
            count = count + 1
            count = count.to_s
            customer_no = "#{prefix}##{count.rjust(3,"0")}"
        else
            count = last.id
            count = count.to_s
            customer_no = "#{prefix}##{count.rjust(3,"0")}"
            return customer_no
        end
    end
end

  def avatar_thumbnail
    if avatar.attached?
      avatar.variant(resize: "80x82!").processed
    else
      "no_profile.png"
    end
  end

  # Auth function for google
  def self.from_omniauth(auth)
    where(email: auth.info.email).first_or_initialize do |user|
      user.first_name = auth.info.name
      user.email = auth.info.email
      user.password = SecureRandom.hex
    end
  end
 

  private

  def add_default_avatar
    unless avatar.attached?
      avatar.attach(
        io: File.open(
          Rails.root.join(
            "app", "assets", "images", "no_profile.png"
          )
        ), filename: "no_profile.png",
        content_type: "image/png",
      )
    end
  end
end
