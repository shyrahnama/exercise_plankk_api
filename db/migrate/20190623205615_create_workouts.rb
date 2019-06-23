class CreateWorkouts < ActiveRecord::Migration[5.2]
  def change
    create_table :workouts do |t|
      t.string :title
      t.text :description
      t.integer :duration_mins
      t.boolean :private

      t.timestamps
    end
  end
end
