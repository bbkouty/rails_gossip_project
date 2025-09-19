class CreatePrivateMessages < ActiveRecord::Migration[8.0]
  def change
    create_table :private_messages do |t|
      t.text :content
      t.references :user_id, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
