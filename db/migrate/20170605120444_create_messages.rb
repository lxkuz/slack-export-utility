class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.integer :channel_id
      t.integer :user_id
      t.integer :team_id
      t.string :slack_id
      t.timestamps
    end
  end
end
