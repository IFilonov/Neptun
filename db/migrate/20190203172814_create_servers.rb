class CreateServers < ActiveRecord::Migration[5.2]
  def change
    create_table :servers do |t|
      t.string :name, null: false
      t.string :ip, null: false

      t.timestamps
    end
  end
end
