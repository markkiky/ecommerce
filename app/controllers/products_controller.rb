class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin!, only: [:index, :new, :edit]

  # GET /products
  # GET /products.json
  def index
    if params[:category].blank?
      @products = Product.all.order("created_at DESC")
   else 
      @category_id = Category.find_by(category_name: params[:category]).id
      @products = Product.where(:category_id => @category_id).order("created_at DESC")
   end 
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
    @wishlist_exists = Wishlist.where(product: @product, customer: current_customer) == [] ? false : true
  end

  # GET /products/new
  def new
    @product = current_admin.products.build
    @categories = Category.all.map{ |c| [c.category_name, c.id] }
    @sizes = Size.all.map{ |s| [s.size_type, s.id] }
    @colors = Color.all.map{ |l| [l.color_type, l.id] }
  end

  # GET /products/1/edit
  def edit
    @categories = Category.all.map{ |c| [c.category_name, c.id] }
    @sizes = Size.all.map{ |s| [s.size_type, s.id] }
    @colors = Color.all.map{ |l| [l.color_type, l.id] }
  end

  # POST /products
  # POST /products.json
  def create
    @product = current_admin.products.build(product_params)
    @product.category_id = params[:category_id]
    @product.size_id = params[:size_id]
    @product.color_id = params[:color_id]
    respond_to do |format|
      if @product.save
        format.html { redirect_to products_path , noticep: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    @product.category_id = params[:category_id]
    @product.size_id = params[:size_id]
    @product.color_id = params[:color_id]
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:product_id, :sku, :id_sku, :vendor_product_id, :product_name, :product_description, :supplier_id, :category_id, :quantity_per_unit, :price, :unit_price, :msrp, :available_size, :available_colors, :size, :color, :discount, :unit_weight, :units_in_stock, :units_on_order, :reorder_level, :product_available, :discount_available, :current_order, :note, :ranking, :product_code, :product_quantity, :size_id, :color_id, images: [])
    end
  end 
