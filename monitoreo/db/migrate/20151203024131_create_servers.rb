class CreateServers < ActiveRecord::Migration
  def change
    create_table :servers do |t|
      t.string :name
      t.string :ip
      t.string :dns

      t.timestamps null: false
    end
  end
end
