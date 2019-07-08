class Lap

  attr_accessor :time, :pilot_id, :pilot_name, :number, :duration, :avg_speed


  TIME_FILE_POSITION = {start_at: 0, size: 18}
  P_ID_FILE_POSITION = {start_at: 18, size: 3}
  P_NAME_FILE_POSITION = {start_at: 24, size: 34}
  NUMBER_FILE_POSITION = {start_at: 58, size: 8}
  DURATION_FILE_POSITION = {start_at: 61, size: 24}
  AVG_SPEED_FILE_POSITION = {start_at: 90, size: 9}


  def initialize(f_lap)
    @time       = f_lap.slice(TIME_FILE_POSITION[:start_at], TIME_FILE_POSITION[:size]).strip
    @pilot_id   = f_lap.slice(P_ID_FILE_POSITION[:start_at], P_ID_FILE_POSITION[:size]).strip
    @pilot_name = f_lap.slice(P_NAME_FILE_POSITION[:start_at], P_NAME_FILE_POSITION[:size]).strip
    @number     = f_lap.slice(NUMBER_FILE_POSITION[:start_at], NUMBER_FILE_POSITION[:size]).strip
    @duration   = f_lap.slice(DURATION_FILE_POSITION[:start_at], DURATION_FILE_POSITION[:size]).strip
    @avg_speed  = f_lap.slice(AVG_SPEED_FILE_POSITION[:start_at], AVG_SPEED_FILE_POSITION[:size]).strip.gsub(',', '.')
  end

  def p_values
    [[@pilot_name, @number, @duration]]
  end

  def duration_in_seconds
    min, sec = @duration.split(':')
    sec = sec.to_f + min.to_f * 60
  end
  
end