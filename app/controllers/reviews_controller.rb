class ReviewsController < ApplicationController
  before_action :find_play
  before_action :authenticate_user!

  def new
    @review.new
  end

  def create
    @review = Review.new(review_params)
    @review.play_id = @play.id
    @review.user_id = current_user.id

    if @review.save
      redirect_to play_path(@play)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @review.update(review_params)
      redirect_to play_path(@play)
    else
      render 'edit'
    end
  end

  def destroy
    @review.destroy

    redirect_to play_path(@play)
  end

  private

  def find_play
    @play = Play.find(params[:play_id])
  end

  def review_params
    params.require(:review).permit(:rating, :comment)
  end

  def find_review
    @review = @play.reviews.find(params[:id])
  end
end