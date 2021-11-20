class CreateRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :rooms do |t|
      t.integer :host_user_id
      t.integer :answerer_user_id
      t.references :post, null: false, foreign_key: true

      t.timestamps
    end
  end
end
