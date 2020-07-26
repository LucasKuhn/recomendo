class DeleteUser
  class << self

    def run(user)
      # singe delete call
      user.likes.delete_all

      #destroy_all calls destroy on each object, deleting associated likes
      user.posts.destroy_all

      user.received_follows.destroy_all
      user.given_follows.destroy_all

      user.image.purge if user.image.attached?

      user.destroy
    end

  end
end
