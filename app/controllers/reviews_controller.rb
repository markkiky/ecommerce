class ReviewsController < ApplicationController
    before_action :find_product
    before_action :find_review, only: [:edit, :update, :destroy]
    before_action :authenticate_customer!, only: [:new, :edit, :create]

    def index 
    end 
    
    def new 
        @review = Review.new
    end 

    def create 
        @review = Review.new(review_params)
        @review.product_id = @product.id
        @review.customer_id = current_customer.id

        if @review.save 
            redirect_to product_reviews_path(@product.id), notice: "Review Created Successfully!"
        else
            render 'new'        
        end
    end 

    def edit
    end

    def update
        if @review.update(review_params)
            redirect_to product_reviews_path(@product.id), notice: "Review Updated Successfully!"
        else 
            render 'edit'
        end
    end

    def destroy
        @review.destroy
        redirect_to product_reviews_path(@product.id), notice: "Review Deleted Successfully!"
    end

    private

    def review_params
        params.require(:review).permit(:rating, :comment)
    end 

    def find_product
        @product = Product.find(params[:product_id])
    end

    def find_review
        @review = Review.find(params[:id])
    end
end
