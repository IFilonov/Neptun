class CreateScenarioServices < ActiveRecord::Migration[5.2]
  def change
    create_table :scenario_services do |t|
      t.references :scenario, foreign_key: true
      t.references :service, foreign_key: true

      t.timestamps
      t.timestamps
    end
    add_column :scenario_services, :order, :integer
  end
end
