class Infos < ActiveRecord::Migration
  def change
    change_column :infos, :cpucharge, :float
    change_column :infos, :diskspace, :float
  end
end
