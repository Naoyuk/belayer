class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.date :date
      t.time :start_time
      t.time :end_time
      t.integer :kind_of_climbing

      t.timestamps
    end
  end
end
