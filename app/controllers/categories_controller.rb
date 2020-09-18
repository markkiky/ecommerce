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

  # POST /categories
  # POST /categories.json
  def create
    # byebug
    @category = current_admin.categories.build(category_params)
    @colors = params[:colors]
    if @colors.count >= 1
      @colors.each do |color| 
        new_color = Color.new
        new_color.color_type = color[:color_type]
        new_color.color_code = color[:color_code]
        new_color.category_id = Category.last.id + 1
        new_color.admin_id = current_admin.id
        new_color.save!
      end
    end
    
    respond_to do |format|
      if @category.save
        format.html { redirect_to categories_path, notice: 'Category was successfully created.' }
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
    respond_to do |format|
      format.js
    end
   end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    @colors = params[:colors]
    if @colors.count >= 1
      @colors.each do |color| 
        if color[:color_id] == nil
          if color[:color_type].length < 1
            # dont update if no color is selected
          else
            new_color = Color.new
            new_color.color_type = color[:color_type]
            new_color.color_code = color[:color_code]
            new_color.category_id = @category.id
            new_color.admin_id = @category.admin_id
            new_color.save!
          end
        else
          update_color = Color.find_by(:id => color[:color_id])
          update_color.update(:color_type =>  color[:color_type], :color_code => color[:color_code])
        end
      end
    end
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to categories_path, notice: 'Category was successfully updated.' }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to categories_url, notice: 'Category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def category_params
      params.require(:category).permit(:category_id, :category_name, :description, :active, color: [])
    end
end
