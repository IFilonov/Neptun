class CreateScenarioServices < ActiveRecord::Migration[5.2]
  def change
    create_table :scenario_services do |t|

      t.timestamps
    end
  end
end
