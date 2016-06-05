class PlaysController < ApplicationController
  before_action :find_play, only: [:show, :edit, :update, :destroy]
  before_action :list_categories, only: [:new, :edit]

  def index
    @plays = Play.all.order("created_at DESC")
  end

  def show
  end

  def new
    @play = current_user.plays.build
  end

  def create
    @play = current_user.plays.build(play_params)
    @play.category_id = params[:category_id]

    if @play.save
      redirect_to @play
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    @play.category_id = params[:category_id]

    if @play.update(play_params)
      redirect_to @play
    else
      render 'edit'
    end
  end

  def destroy
    @play.destroy
    redirect_to root_path
  end

  private

  def find_play
    @play = Play.find(params[:id])
  end

  def play_params
    params.require(:play).permit(:title, :description, :director, :category_id)
  end

  def list_categories
    @categories = Category.all.map{ |c| [c.name, c.id ]}
  end

end
