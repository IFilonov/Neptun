class AddStateToService < ActiveRecord::Migration[5.2]
  def change
    add_column :services, :state, :string
    add_reference :services, :user, foreign_key: true
  end
end
