class RenameThreadIdToAnswers < ActiveRecord::Migration[6.1]
  def change
    rename_column :answers, :thread_id, :room_id
  end
end
