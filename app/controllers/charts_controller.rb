class ChartsController < ApplicationController

  def line_labels
    distances = Array.new
    durations = Array.new
    paces = Array.new
    dates = Array.new
    count = params[:count] ? params[:count] : 30
    Workout.where(:endo_sport_id => params[:sport_id]).order("start_time DESC").limit(count).each do |w|
      if w.distance
        distances.unshift((w.distance_km / 1000))
      end
      if w.duration
        durations.unshift(w.duration_sec)
      end
      if w.start_time
        dates.unshift(w.start_time.to_date)
      end
      if w.duration and w.distance
        paces.unshift((w.duration_sec / (w.distance_km/1000)).round(2))
      end
    end
    @chart = LazyHighCharts::HighChart.new('line_labels') do |f|
      f.chart({
         type: 'line'
      })
      f.title({
        text: 'Stats'
      })
      f.subtitle({
          text: 'Trine Larsen'
      })
      f.xAxis({
        categories: dates
      })
      f.yAxis({
      })
      f.tooltip({
        enabled: false,
        formatter: %|function() {
                             return '<b>'+ this.series.name +'</b><br/>'+
                                 this.x +': '+ this.y +'°C';
                         }|.js_code

      })
      f.plotOptions({
         line: {
                 dataLabels: {
                                     enabled: true
                                 },
                           enableMouseTracking: false
                       }
      })
      f.series({
        name: 'Distance (km)',
        data: distances
      })
      f.series({
        name: 'Duration (minutes)',
        data: durations,
        visible: false,
        legendIndex: 500
      })
      f.series({
        name: 'Pace (min/km)',
        data: paces
      })
    end
  end
end
