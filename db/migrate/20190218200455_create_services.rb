class CreateServices < ActiveRecord::Migration[5.2]
  def change
    create_table :services do |t|
      t.string :name, null: false, default: ""
      t.string :path
      t.integer :group
      t.string :start
      t.string :stop
      t.references :server, foreign_key: true
      t.integer :status

      t.timestamps
    end
  end
end
