json.array!(@workouts) do |workout|
  json.extract! workout, :id, :username, :sport, :endo_sport_id, :distance, :start_time, :duration
  json.url workout_url(workout, format: :json)
end
