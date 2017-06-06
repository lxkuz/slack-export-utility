class AddIndexes < ActiveRecord::Migration[5.0]
  def change
    add_index :messages, :channel_id
    add_index :messages, :user_id
    add_index :users, :team_id
    add_index :channels, :team_id
    add_index :teams, :slack_id
    add_index :messages, :slack_id
    add_index :users, :slack_id
    add_index :channels, :slack_id
  end
end
