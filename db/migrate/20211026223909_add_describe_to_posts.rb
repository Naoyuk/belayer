class AddDescribeToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :describe, :text
  end
end
