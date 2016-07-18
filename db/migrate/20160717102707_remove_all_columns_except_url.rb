class RemoveAllColumnsExceptUrl < ActiveRecord::Migration[5.0]
  def change
    remove_column :posts, :title
    remove_column :posts, :comment
    remove_column :posts, :date
  end
end
