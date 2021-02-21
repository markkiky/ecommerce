class HomesController < ApplicationController
  def index
    @notifications = Home.all
    # console
    if params[:category].blank?
      @products = Product.all.order("created_at DESC")
      @categories = Category.all
      @subcategories = SubCategory.all
      @years = Category.all
    else
      @category_id = Category.find_by(category_name: params[:category]).id
      @products = Product.where(:category_id => @category_id).order("created_at DESC")
    end
  end

  def advanced_search
    puts "The ethethi: #{search_params[:category_id]}"
    puts params
    @category = Category.find(search_params[:category_id])
    @sub_categories = SubCategory.where(:category_id => @category.id)
    @products = Product.where(:category_id => @category.id)
    @sub_category = nil
    @year = nil
    if search_params[:sub_category_id].empty? == false
      @sub_category = SubCategory.where(:id => search_params[:sub_category_id])
      if search_params[:year].empty? == false
        products = Product.where(:year => search_params[:year], :category_id => search_params[:category_id], :sub_category_id => search_params[:sub_category_id])
        if products.count == 0
        else
          @products = products
        end
      end
    end
    puts "Product  found #{@products.count}"

    # returns products matching the criteria
    respond_to do |format|
      format.html
    end
  end

  # GET /get_sub_categories
  def get_sub_categories
    category = params[:category_id]

    @subcategories = SubCategory.where(:category_id => category)
  end

  def get_years
    category = params[:category_id]

    @products = Product.where(:category_id => category)
    @years = []

    if @products.count > 0
      # populate years
      @products.each do |product|
        @years << product.year
      end
    else
      # return zero years

    end
  end

  def new
    @notificaton = Home.new
  end

  def create
    @notification = Home.new(notification_params)
    if @notification.save
      redirect_to contact_path, notice: "Message Sent Successfully!"
    else
      render :new
    end
  end

  private

  def notification_params
    params.require(:home).permit(:notification_first_name, :notification_last_name, :notification_phone_number, :notification_email, :notification_message, images: [])
  end

  def search_params
    params.require(:home).permit(:category_id, :sub_category_id, :year)
  end
end
