class AddExportFilePathToTeams < ActiveRecord::Migration[5.0]
  def change
    add_column :teams, :file, :string
  end
end
