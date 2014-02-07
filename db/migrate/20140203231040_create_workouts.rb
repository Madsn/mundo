class CreateWorkouts < ActiveRecord::Migration
  def change
    create_table :workouts do |t|
      t.integer  :user_id
      t.integer  :endo_workout_id
      t.string   :username
      t.string   :sport, limit: 50
      t.integer  :endo_sport_id
      t.float    :distance_km
      t.integer  :duration_sec
      t.float    :max_speed_kmh
      t.integer  :calories
      t.datetime :start_time

      t.timestamps
    end
    add_index :workouts, :user_id
    add_index :workouts, :endo_workout_id
    add_index :workouts, :endo_sport_id
  end
end
