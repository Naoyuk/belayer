class CreateAnswers < ActiveRecord::Migration[6.1]
  def change
    create_table :answers do |t|
      t.text :body
      t.boolean :read, null: false, default: false
      t.datetime :snoozed_at

      t.timestamps
    end
  end
end
