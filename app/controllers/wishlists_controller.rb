class WishlistsController < ApplicationController
  before_action :find_wishlist, only: [:destroy]
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

  def destroy
    @wishlist.destroy
    respond_to do |format|
      format.html { redirect_to wishlists_url, notice: 'Wish was successfully removed.' }
      format.json { head :no_content }
    end
  end

  private 
  def find_wishlist
    @wishlist = Wishlist.find(params[:id])
  end
end
