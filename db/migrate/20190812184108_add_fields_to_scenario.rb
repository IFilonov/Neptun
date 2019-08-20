class AddFieldsToScenario < ActiveRecord::Migration[5.2]
  def change
    add_column :scenarios, :name, :string
    add_column :scenarios, :user_id, :integer
    add_column :scenario_services, :scenarios_id, :integer
    add_column :scenario_services, :services_id, :integer
    add_column :scenario_services, :order, :integer
  end
end
