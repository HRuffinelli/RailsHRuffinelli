class CreateRules < ActiveRecord::Migration
  def change
    create_table :rules do |t|
      t.string :name
      t.float :cpuchargeexceed
      t.float :diskspaceexceed
      t.integer :timeexceed

      t.timestamps null: false
    end
  end
end
