class AddPositionToGroup < ActiveRecord::Migration[5.2]
  def change
    add_column :groups, :position, :integer, null: false, default: 0
  end
end
