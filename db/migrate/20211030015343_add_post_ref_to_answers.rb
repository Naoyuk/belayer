class AddPostRefToAnswers < ActiveRecord::Migration[6.1]
  def change
    add_reference :answers, :post, null: false, foreign_key: true
  end
end
