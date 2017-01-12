class ReviewsController < ApplicationController

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = @restaurant.reviews.new
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = @restaurant.build_review(review_params, current_user)
    if @review.save
      redirect_to '/restaurants'
    else
      if @review.errors[:user]
        redirect_to '/restaurants'; flash[:notice] = "Has reviewed this restaurant already"
      else
        render :new
      end
    end
  end

  private

  def review_params
    params.require(:review).permit(:thoughts, :rating)
  end
end
