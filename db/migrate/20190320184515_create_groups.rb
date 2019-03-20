class CreateGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :groups do |t|
      t.string :name, null: false, default: ""
      t.boolean :align_left, null: false, default: true

      t.timestamps
    end
  end
end
