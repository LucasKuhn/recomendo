class AddUrlDataToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :url_data, :jsonb
  end
end
