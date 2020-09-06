class Post < ApplicationRecord
  acts_as_taggable
  belongs_to :category
  belongs_to :user
  has_many :likes, dependent: :destroy

  scope :posted_by, ->(user) { where user: user }

  default_scope { order(created_at: :desc) }

  after_save :update_url_metadata, if: :saved_change_to_url?

  def self.filter(params)
    posts = Post.all
    posts = posts.where(category_id: params[:category_id]) if params[:category_id]
    posts = posts.tagged_with(params[:tags]) if params[:tags]
    posts
  end

  def update_url_metadata
    metadata = GetUrlData.new(url).run
    update(url_data: metadata)
  end

end
