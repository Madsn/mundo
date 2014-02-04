class ChartsController < ApplicationController

  def line_labels
    distances = Array.new
    durations = Array.new
    Workout.all.each do |w|
      distances << w.distance
      durations << w.duration
    end
    @chart = LazyHighCharts::HighChart.new('line_labels') do |f|
      f.chart({
         type: 'line'
      })
      f.title({
        text: 'Monthly Average Temperature'
      })
      f.subtitle({
          text: 'Source: WorldClimate.com'
      })
      f.xAxis({
        categories: ['Jan', 'Feb', 'Mar']
      })
      f.yAxis({
         title: {
                             text: 'Temperature (°C)'
                         }
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
        name: 'Test',
        data: distances
      })
      f.series({
        name: 'Blap',
        data: durations
      })
    end
  end
end
