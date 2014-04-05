class ChartsController < ApplicationController

  def line_labels
    distances = Array.new
    durations = Array.new
    paces = Array.new
    dates = Array.new
    count = params[:count] ? params[:count] : 30
    Workout.where(:user_id => current_user[:id], :sport => params[:sport_id].to_i).order_by(:start_time.desc).limit(count).each do |w|
      if not (w['distance_km'].blank? or w['distance_km'] == 0)
        distances.unshift((w['distance_km'].round(2)))
        dates.unshift(w['start_time'].to_date)
        paces.unshift(((w['duration_sec']/60) / (w['distance_km'])).round(2))
        durations.unshift((w['duration_sec']/60).round(2))
      end
    end
    subtitle_text = ""
    if not dates[0]
      subtitle_text = 'No data available'
    else
      subtitle_text = 'Date interval: ' + dates[0].strftime('%B %d, %Y') + ' -> ' + dates.last().strftime('%B %d, %Y')
    end
    @chart = LazyHighCharts::HighChart.new('line_labels') do |f|
      f.chart({
         type: 'scatter'
      })
      f.title({
        text: 'Stats (sport id: ' + params[:sport_id] + ")"
      })
      f.subtitle({
            text: subtitle_text
      })
      f.xAxis({
        categories: dates
      })
      f.yAxis({
      })
      f.tooltip({
        enabled: true,
        formatter: %|function() {
                             return '<b>'+ this.series.name +'</b><br/>'+
                                 this.x +': '+ this.y;
                         }|.js_code
      })
      f.plotOptions({
         series: {
             enableMouseTracking: true,
             dataLabels: {
                 enabled: true
             }
           }
      })
      f.series({
        name: 'Distance (km)',
        data: distances,
        dataLabels: {
            format: '{y} km'
        }
      })
      f.series({
        name: 'Duration (minutes)',
        data: durations,
        visible: false,
        legendIndex: 500,
        dataLabels: {
            format: '{y} min'
        }
      })
      f.series({
        name: 'Pace (min/km)',
        data: paces,
        dataLabels: {
            format: '{y} min/km'
        }
      })
    end
  end
end
