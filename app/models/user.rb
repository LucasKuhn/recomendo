class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable

  has_many :posts
  has_many :likes

  has_one_attached :image

  has_many :received_follows, foreign_key: :followed_user_id, class_name: "Follow"
  has_many :followers, through: :received_follows, source: :following_user

  has_many :given_follows, foreign_key: :following_user_id, class_name: "Follow"
  has_many :followings, through: :given_follows, source: :followed_user

  after_create :follow_self!

  def follow_self!
    given_follows.create(followed_user: self)
  end

  def follows?(user)
    given_follows.where(followed_user: user).exists?
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def profile_image
    if image.attached?
      image
    else
      "https://avatars.dicebear.com/api/initials/#{full_name}.svg"
    end
  end

  def thumbnail
    if image.attached?
      image.variant(resize: 100)
    else
      adorable_avatar
    end
  end

  def adorable_avatar
    "https://avatars.dicebear.com/api/initials/#{full_name}.svg"
  end

  # https://mensfeld.pl/2013/12/rails-devise-and-remember_me-rememberable-by-default/
  def remember_me
    true
  end

end
