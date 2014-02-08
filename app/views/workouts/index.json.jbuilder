json.array!(@workouts) do |workout|
  json.extract! workout, :id, :username, :sport, :distance_km, :start_time, :duration_sec
  json.url workout_url(workout, format: :json)
end
