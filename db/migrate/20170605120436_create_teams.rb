class CreateTeams < ActiveRecord::Migration[5.0]
  def change
    create_table :teams do |t|
      t.string :name
      t.string :token
      t.string :slack_id
      t.timestamps
    end
  end
end
