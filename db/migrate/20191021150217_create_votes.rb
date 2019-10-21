class CreateVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :votes do |t|
      t.integer :poll_id
      t.integer :user_id
      t.boolean :vote
      t.timestamps
    end
  end
end
