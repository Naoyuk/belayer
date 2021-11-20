class AddThreadIdToAnswers < ActiveRecord::Migration[6.1]
  def change
    add_column :answers, :thread_id, :integer
    add_index :answers, :thread_id
  end
end
