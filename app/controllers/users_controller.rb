class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

  def index
    @users = User.where.not(id: current_user).order(followers_count: :desc)
  end

  def show
    @pagy, @posts = pagy(Post.filter(params).posted_by(@user), items: 4)
    @filtered_category = Category.find(params[:category_id]) if params[:category_id]
    respond_to do |format|
      format.html
      format.json {
        render json: {
          entries: render_to_string(@posts, formats: [:html]), pagination: view_context.pagy_nav(@pagy)
        }
      }
    end
  end

  def edit
    @edit
  end

  def update
    @user.update(user_params)
    redirect_to @user
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    # https://github.com/janko/image_processing/blob/master/doc/minimagick.md#resize_to_fill
    # https://tosbourn.com/active-storage-image-compression/
    if params[:user][:image].present?
      tempfile = params[:user][:image].tempfile
      result = ImageProcessing::MiniMagick.source(tempfile).resize_to_fill!(500,500)
      params[:user][:image].tempfile = result
    end

    params.require(:user).permit(:first_name, :last_name, :image)
  end


end
