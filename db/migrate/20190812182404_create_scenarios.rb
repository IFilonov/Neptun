class CreateScenarios < ActiveRecord::Migration[5.2]
  def change
    create_table :scenarios do |t|
      t.string :name
      t.timestamps
    end

    add_reference :scenarios, :user, foreign_key: true
  end
end
