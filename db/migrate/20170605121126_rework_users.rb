class ReworkUsers < ActiveRecord::Migration[5.0]
  def up
    drop_table :users
    create_table :users do |t|
      t.string :name
      t.integer :team_id
      t.string :slack_id
      t.timestamps
    end
  end

  def down
    drop_table :users
    create_table :users do |t|
      t.string :provider
      t.string :string
      t.string :name
      t.string :uid
      t.timestamps
    end
  end
end
