class CreateWorkouts < ActiveRecord::Migration
  def change
    create_table :workouts do |t|
      t.string :username
      t.string :sport, limit: 50
      t.integer :endo_sport_id
      t.integer :distance
      t.date :start_time
      t.time :duration

      t.timestamps
    end
    add_index :workouts, :username
    add_index :workouts, :endo_sport_id
  end
end
