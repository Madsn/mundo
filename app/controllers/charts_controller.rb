class ChartsController < ApplicationController

  def line_labels
    distances = Array.new
    durations = Array.new
    paces = Array.new
    dates = Array.new
    count = params[:count] ? params[:count] : 30
    Workout.where(:user_id => current_user[:id], :sport => params[:sport_id].to_i).order_by(:start_time.asc).limit(count).each do |w|
      if not w['distance_km'].blank?
        distances.unshift((w['distance_km'].round(2)))
        dates.unshift(w['start_time'].to_date)
        paces.unshift(((w['duration_sec']/60) / (w['distance_km'])).round(2))
      end
      durations.unshift((w['duration_sec']/60).round(2))
    end
    @chart = LazyHighCharts::HighChart.new('line_labels') do |f|
      f.chart({
         type: 'line'
      })
      f.title({
        text: 'Stats (sport id: ' + params[:sport_id] + ")"
      })
      f.subtitle({
          text: 'Date interval: ' + dates[0].strftime('%B %d, %Y') + ' -> ' + dates.last().strftime('%B %d, %Y')
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
