require_relative 'lap'

class Pilot

  attr_accessor :id, :name, :laps, :position, :best_lap, :def_avg_speed, :laps_completed, :avg_speed,
              :last_lap_time, :total_time

  def initialize(id, laps)
    @id = id
    @laps = laps
    @name = laps.first.pilot_name
    @best_lap = def_best_lap
    @laps_completed = @laps.size
    @avg_speed = def_avg_speed
    @last_lap_time = def_last_lap_time
    @total_time = def_total_time
  end

  private

  def def_best_lap
    blap = @laps.sort_by{ |s| s.duration }.first
    {number: blap.number, time: blap.duration}
  end

  def def_avg_speed
    (@laps.inject(0){|sum, l| sum + l.avg_speed.to_f } / @laps_completed).round(3)
  end

  def def_last_lap_time
    @laps.select{|l| l.number == '4' }.first.time rescue 'NA'
  end

  def def_total_time
    total_time_seconds = (@laps.inject(0){|sum, l| sum + l.duration_in_seconds}).round(3)
    min = total_time_seconds / 60
    sec = total_time_seconds % 60
    "#{min.to_i}:#{sec.round(3)}"
  end
  
end