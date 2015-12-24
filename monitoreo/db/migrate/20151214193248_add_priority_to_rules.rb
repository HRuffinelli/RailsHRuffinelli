class AddPriorityToRules < ActiveRecord::Migration
  def change
    add_column :rules, :priority, :integer
  end
end
