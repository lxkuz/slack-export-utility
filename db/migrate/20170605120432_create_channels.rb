class CreateChannels < ActiveRecord::Migration[5.0]
  def change
    create_table :channels do |t|
      t.string :name
      t.string :team_id
      t.string :slack_id
      t.timestamps
    end
  end
end
