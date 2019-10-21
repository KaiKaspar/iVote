class CreatePolls < ActiveRecord::Migration[5.2]
  def change
    create_table :polls do |t|
      t.integer :user_id
      t.string :question
      t.string :answer_one
      t.string :answer_two
      t.timestamps
    end
  end
end
