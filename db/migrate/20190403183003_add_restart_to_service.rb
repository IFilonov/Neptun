class AddRestartToService < ActiveRecord::Migration[5.2]
  def change
    add_column :services, :restart, :string
  end
end
