class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :read_more]

  # GET /posts
  # GET /posts.json
  def index
    if params[:all].present?
      posts = Post.filter(params)
    else
      posts = Post.filter(params).posted_by(current_user.followings)
    end
    @pagy, @posts = pagy(posts, items: 2)
    @filtered_category = Category.find(params[:category_id]) if params[:category_id]
    @filtered_tags = params[:tags]
    @posts_from_all = params[:all].present?
    respond_to do |format|
      format.html
      format.json {
        render json: {
          entries: render_to_string(@posts, formats: [:html]), pagination: view_context.pagy_nav(@pagy)
        }
      }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    if false # TODO -> Hack way to reload when coming from JS
      flash[:alert] = "Something went wrong ..."
      render "reload"
    end
  end

  # GET /posts/new
  def new
    @post = Post.new(user: current_user)
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    if !@post.category
      @post.category = Category.last
    end
    @post.user = current_user
    respond_to do |format|
      if @post.save
        format.html { redirect_to posts_path, notice: 'Recomendação criada' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Postagem apagada' }
      format.json { head :no_content }
    end
  end

  def search_params
    params.permit(:category_id)
  end

  def read_more
    respond_to do |format|
      format.js { render js: "document.querySelector('#post_#{@post.id} .card-text').innerHTML = `#{@post.body.gsub(/\n/, '<br/>')}` " }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def post_params
    params.require(:post).permit(:title, :body, :category_id, :url, :tag_list)
  end


end
