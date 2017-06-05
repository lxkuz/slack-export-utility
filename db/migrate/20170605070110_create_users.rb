class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :provider
      t.string :string
      t.string :name
      t.string :uid
      t.timestamps
    end
  end
end
