class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin!, only: [:new, :edit, :index_admin]

  # skip_before_action :verify_authenticity_token, only: [:product_counter, :change_product]

  # GET /products
  # GET /products.json
  def index
    if params[:category].blank?
      @products = Product.all.order("created_at DESC")
    else
      @category_id = Category.find_by(category_name: params[:category]).id
      @category = Category.find_by(category_name: params[:category])
      @products = Product.where(:category_id => @category_id).order("created_at DESC")
    end
  end

  def index_admin
    @products = Product.all.order("created_at DESC")
  end

  def search
    if params[:q].blank?
      redirect_to(root_path, alert: "Search Field Empty!") and return
    else
      @products = Product.where("product_name LIKE ? OR product_description LIKE ?", "%" + params[:q] + "%", "%" + params[:q] + "%")
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show
    # console
    @available_products = @product.product_quantity
    if @product.reviews.blank?
      @average_review = 0
    else
      @average_review = @product.reviews.average(:rating).round(2)
    end
    @wishlist_exists = Wishlist.where(product: @product, customer: current_customer) == [] ? false : true
  end

  # GET /products/new
  def new
    @product = current_admin.products.build
    @categories = Category.all
    @subcategories = SubCategory.all
    # @sizes = Size.all.map{ |s| [s.size_type, s.id] }
    # @colors = Color.all.map{ |l| [l.color_type, l.id] }
  end

  def crop_pic
    puts params
    puts "Cropping"

    gon.image = params[:image_data]
  end

  def pic_added
    puts "pic added"
    gon.image = params[:image_data]
  end

  def get_sub_categories
    category = params[:category_id]

    @subcategories = SubCategory.where(:category_id => category)
  end

  # GET /products/1/edit
  def edit
    @category = Category.where(:id => @product.category_id)
    @categories = Category.all
    @subcategories = SubCategory.where(:category_id => @product.category_id)
    # @sizes = Size.all.map{ |s| [s.size_type, s.id] }
    # @colors = Color.all.map{ |l| [l.color_type, l.id] }
    # @data_id = 1
  end

  # POST /products
  # POST /products.json
  def create
    @product = current_admin.products.build(product_params)
    # @product.category_id = params[:category_id]
    # @product.size_id = params[:size_id]
    # @product.color_id = params[:color_id]

    # byebug
    respond_to do |format|
      # byebug
      if @product.save
        # params[:product][:size].each do |size|
        #   puts size[:number].to_i
        #   number = size[:number].to_i

        #   while number > 1
        #     ProductSize.create!(:product_id => @product.id, :size_id => size["size_id"])
        #     number = number - 1
        #   end
        # end
        format.html { redirect_to admin_products_url, notice: "Product was successfully created." }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { redirect_to new_product_url, notice: "error saving product #{@product.errors}" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    # @product.category_id = params[:category_id]
    @product.size_id = params[:size_id]
    @product.color_id = params[:color_id]
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to admin_products_path, notice: "Product was successfully updated." }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /product_counter
  def product_counter
    puts params[:product_count]
    @category_id = params[:category_id]
    @product_count = params[:product_count]
    @colors = Color.where(:category_id => @category_id).map { |l| [l.color_type, l.id] }
    @sizes = Size.where(:category_id => @category_id)
    respond_to do |format|
      format.js
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    begin
      @product.destroy
      # work on marking items as inactive and not deleteing them
    rescue => exception
      respond_to do |format|
        format.html { redirect_to admin_products_path, alert: "Failed to delete Product." }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to admin_products_path, notice: "Product was successfully destroyed." }
        format.json { head :no_content }
      end
    end
  end

  # POST /change_image
  def change_product
    @data_id = params[:data_id]
    product_id = params[:product_id]
    puts product_id

    @product = Product.find(product_id)
    respond_to do |format|
      format.js
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def product_params
    params.require(:product).permit(:product_id, :sku, :id_sku, :vendor_product_id, :year, :product_name, :product_description, :supplier_id, :category_id, :quantity_per_unit, :price, :unit_price, :msrp, :available_size, :available_colors, :size, :color, :discount, :unit_weight, :units_in_stock, :units_on_order, :reorder_level, :product_available, :discount_available, :current_order, :note, :ranking, :product_code, :product_quantity, :size_id, :color_id, :sub_category_id, images: [], color_ids: [], size_ids: [])
  end
end
