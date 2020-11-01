class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin!, only: [:index, :new, :edit]

  # GET /categories
  # GET /categories.json
  def index
    @categories = Category.all
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
  end

  # GET /categories/new
  def new
    @category = current_admin.categories.build

    respond_to do |format|
      format.js
    end
  end

  # GET /add_color
  def add_color
    respond_to do |format|
      format.js
    end
  end

  # GET /remove_color
  def remove_color
    respond_to do |format|
      format.js
    end
  end

  # GET /add_size
  def add_size
    respond_to do |format|
      format.js
    end
  end

  # GET /variants
  def variants
    respond_to do |format|
      format.html
    end
  end
  # POST /categories
  # POST /categories.json
  def create
    # byebug

    # @colors = params[:colors]
    # if @colors.count >= 1
    #   @colors.each do |color|
    #     new_color = Color.new
    #     new_color.color_type = color[:color_type]
    #     new_color.color_code = color[:color_code]
    #     if Category.all.count == 0
    #       new_color.category_id = 1
    #     else
    #       new_color.category_id = Category.last.id + 1
    #     end
    #     new_color.admin_id = current_admin.id
    #     # new_color.save!
    #   end
    # end

    # @sizes = params[:sizes]
    # if @sizes.count >= 1
    #   @sizes.each do |size|
    #     new_size = Size.new
    #     new_size.size_type = size[:size_type]
    #     # new_color.color_code = color[:color_code]
    #     if Category.all.count == 0
    #       new_size.category_id = 1
    #     else
    #       new_size.category_id = Category.last.id + 1
    #     end
    #     new_size.admin_id = current_admin.id
    #     new_size.save!
    #   end
    # end
    @category = current_admin.categories.build(category_params)
    # Category.create(:category_name => "MIMI", :variants => {:moq => "5l"})
    @category.variants = {

      :product_description => ["50ml with mint scent", "100ml with mint scent", "5L with mint scent", "20L with mint scent"],
      :rrp => ["100", "180", "2060", "8000"],
      :whole_sale => ["80", "140", "2060", "8000"],
      :moq => ["240", "240", "2", "1"],
      :moq_description => ["10 dozens (240 pieces)", "10 dozens (240 pieces)", "2 jericans", "1 Jerican"],
      :name => ['50ml', '100ml', '5L', '20L']
    } 
    respond_to do |format|
      if @category.save
        format.html { redirect_to categories_path, notice: "Category was successfully created." }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /categories/1/edit
  def edit
    @colors = Color.where(:category_id => @category.id)
    @sizes = Size.where(:category_id => @category.id)
    puts "sizes: #{@sizes}"
    respond_to do |format|
      format.js
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    # @colors = params[:colors]
    # if @colors.count >= 1
    #   @colors.each do |color|
    #     if color[:color_id] == nil
    #       if color[:color_type].length < 1
    #         # dont update if no color is selected
    #       else
    #         new_color = Color.new
    #         new_color.color_type = color[:color_type]
    #         new_color.color_code = color[:color_code]
    #         new_color.category_id = @category.id
    #         new_color.admin_id = @category.admin_id
    #         # new_color.save!
    #       end
    #     else
    #       update_color = Color.find_by(:id => color[:color_id])
    #       # update_color.update(:color_type =>  color[:color_type], :color_code => color[:color_code])
    #     end
    #   end
    # end
    # @sizes = params[:sizes]
    # if @sizes.count >= 1
    #   @sizes.each do |size|
    #     if size[:size_type] == nil
    #       if size[:size_type].length < 1
    #         # dont update if no color is selected
    #       else
    #         new_size = Size.new
    #         new_size.size_type = size[:size_type]
    #         # new_color.color_code = color[:color_code]
    #         new_size.category_id = @category.id
    #         new_size.admin_id = @category.admin_id
    #         new_color.save!
    #       end
    #     else
    #       update_size = Size.find_by(:id => size[:size_id])
    #       update_size.update(:size_type =>  size[:size_type])
    #     end
    #   end
    # end
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to categories_path, notice: "Category was successfully updated." }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def category_variants
    @category = Category.find(params[:id])
    @order_id = @category.id
    # @category = Category.find(category_id)

    @categories = Category.all
    # byebug
    respond_to do |format|
      format.html
    end
  end

  def get_variants
    @category = Category.find(params[:id])
    gon.variants = @category.variants
    # respond_to do |format|
    #   # format.html
    #   format.js
    # end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to categories_url, notice: "Category was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # sub category actions 
  # show
  def show_sub_category
    params[:id]
    @category = Category.find(params[:id])
    @subcategories = SubCategory.where(:category_id => params[:id])
  end

  # new subcategory
  def new_sub_category
    @category = Category.find(params[:id])
    @sub_category = SubCategory.new
  end

  # Create subcategory
  def create_subcategory
    @sub_category = SubCategory.new(sub_category_params)
    respond_to do |format|
      if @sub_category.save
        format.html { redirect_to categories_path, notice: "Sub Category was successfully created." }
        format.json { render :show, status: :created, location: @sub_category }
      else
        format.html { render :new }
        format.json { render json: @sub_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET EDIT SUBCATEGORY
  def edit_sub_category
    @category = Category.find(params[:id])
    @sub_category = SubCategory.last
    @subcategories = SubCategory.where(:category_id => @category.id)
    puts @subcategories.name
    
  end

  # PATCH UPDATE SUBCATEGORY
  def update_subcategory
    
    @category = Category.find(sub_category_params[:category_id])
    count = 0
    sub_category_params[:sub_category_id].each do |sub_category|
      @sub_category = SubCategory.find(sub_category)
      @sub_category.update(:name => sub_category_params[:name][count])
      count += 1 
    end

    
    # respond_to do |format|
    #   if @sub_category.update(category_params)
    #     format.html { redirect_to categories_path, notice: "Category was successfully updated." }
    #     format.json { render :show, status: :ok, location: @category }
    #   else
    #     format.html { render :edit }
    #     format.json { render json: @category.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # GET SUBCATEGORY DELETE VIEW
  def delete_sub_category
    params[:category_id]
  end

  # DELETE SUBCATEGORY
  def delete_subcategory

  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_category
    @category = Category.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def category_params
    params.require(:category).permit(:category_id, :category_name, :description, :active, :image , color: [], variants: [])
  end

  def sub_category_params
    params.require(:sub_category).permit(:name, :category_id, name: [], sub_category_id: [])
  end
end
