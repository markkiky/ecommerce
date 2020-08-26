class WishlistsController < ApplicationController
  before_action :authenticate_customer!, only: [:index]

  def update
    wishlist = Wishlist.where(product: Product.find(params[:product]), customer: current_customer)
    if wishlist == []
        Wishlist.create(product: Product.find(params[:product]), customer: current_customer)
        @wishlist_exists = true
    else 
        wishlist.destroy_all
        @wishlist_exists = false
    end
      respond_to do | format |
        format.html {}
        format.js {}
    end
  end
end
