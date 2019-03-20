class AddGroupToServices < ActiveRecord::Migration[5.2]
  def change
    remove_column :services, :group
    add_reference :services, :group, foreign_key: true
  end
end
