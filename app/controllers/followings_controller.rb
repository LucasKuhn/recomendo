class FollowingsController < ApplicationController
  before_action :set_user

  def show
    followings = @user.followings.where.not(id: @user.id)
    @pagy, @users = pagy(followings, items: 6)
    respond_to do |format|
      format.html
      format.json {
        render json: {
          entries: render_to_string(@users, formats: [:html]), pagination: view_context.pagy_nav(@pagy)
        }
      }
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

end
