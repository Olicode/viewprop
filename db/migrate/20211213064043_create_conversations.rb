class CreateConversations < ActiveRecord::Migration[6.1]
  def change
    create_table :conversations do |t|
      t.integer :sender_id, null: false, foreign_key: true
      t.integer :receiver_id, null: false, foreign_key: true

      t.timestamps
    end
  end
end
