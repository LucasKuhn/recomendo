class SearchController < ApplicationController

  def users
    if params[:q].present?
      users = User.where("CONCAT(first_name, ' ' ,last_name) ILIKE ?", "%#{params[:q]}%").order(followers_count: :desc, created_at: :desc)
    else
      users = User.all.order(followers_count: :desc, created_at: :desc)
    end
    @pagy, @users = pagy(users, items: 8)
    respond_to do |format|
      format.html
      format.js
      format.json {
        render json: {
          entries: render_to_string(partial: "/users/user", collection: @users, formats: [:html]), pagination: view_context.pagy_nav(@pagy)
        }
      }
    end
  end

  def posts
    if params[:q].present?
      posts = Post.where("title ILIKE ?", "%#{params[:q]}%").order(created_at: :desc)
    else
      posts = Post.all.order(created_at: :desc)
    end
    @pagy, @posts = pagy(posts, items: 8)
    respond_to do |format|
      format.html
      format.js
      format.json {
        render json: {
          entries: render_to_string(partial: "/posts/post", collection: @posts, formats: [:html]), pagination: view_context.pagy_nav(@pagy)
        }
      }
    end
  end

end
