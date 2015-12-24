class CreateInfos < ActiveRecord::Migration
  def change
    create_table :infos do |t|
      t.references :server, index: true, foreign_key: true
      t.decimal :cpucharge
      t.decimal :diskspace

      t.timestamps null: false
    end
  end
end
