class ReviewsController < ApplicationController

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = @restaurant.reviews.new
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = @restaurant.reviews.build_with_user(review_params, current_user)
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

  def destroy
    user = current_user
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.find(params[:id])
    p params
    p @review

      if user.reviews.include?(@review)
        @review.destroy
        flash[:notice] = "You deleted your review"
        redirect_to '/'
      else
        flash[:notice] = "That's not your review to delete!"
        redirect_to '/'
      end
  end

  private

  def review_params
    params.require(:review).permit(:thoughts, :rating)
  end
end
