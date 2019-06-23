class RenameWorkoutPrivate < ActiveRecord::Migration[5.2]
  def change
    rename_column :workouts, :private, :is_private
    change_column :workouts, :is_private, :boolean, default: :false
  end
end
