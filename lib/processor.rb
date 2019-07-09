require 'terminal-table'
require_relative 'lap'
require_relative 'pilot'

class Processor

  attr_reader :race_file, :laps, :pilots, :race_results, :best_lap_by_pilot, :race_best_lap,
            :avg_speed

  def initialize(file_path)
    @race_file = read(file_path)
    @laps = []
    @pilots = []
    @race_results = []
    @best_lap_by_pilot = []
    @race_best_lap = nil
    @avg_speed = []
  end

  def read(file_path)
    if File.exists? file_path
      return File.readlines(file_path) rescue nil
    else
      puts "The file path is invalid"
      return nil
    end
  end

  def process
    if @race_file

      get_laps_and_pilots
      get_race_results
      get_best_lap_by_pilot
      get_race_best_lap
      get_avg_speed

      puts "Race results successfully processed"
    else
      puts "Race results was not defined yet. Please set a valid race results file"
    end
  end

  def get_laps_and_pilots
    @race_file.each do |f_lap|
      @laps << Lap.new(f_lap)        
    end
    
    @laps.group_by{|l| l.pilot_id}.each do |p_id, laps|
      @pilots << Pilot.new(p_id, laps)
    end
  end

  def get_race_results
    @pilots.sort_by{ |p| p.last_lap_time }.each_with_index do |p, index|
      @race_results << {position: index + 1, p_id: p.id, p_name: p.name, qtd_lap: p.laps.size, total_time: p.total_time}
    end
  end

  def print_race_results
    if @race_results && !@race_results.empty?
      Terminal::Table.new(title: "Gympass Race Results", headings: [ '#', 'Pilot ID', 'Pilot name', 'Number of LAPS', 'Total time'], rows: @race_results.map{|p| p.values})
    else
      "Race results unprocessed. Please run step 2 before trying this"
    end
  end

  def get_best_lap_by_pilot
    @pilots.each do |p|
      @best_lap_by_pilot << {name: p.name, blap_number: p.best_lap[:number], blap_time: p.best_lap[:time] }
    end

    @best_lap_by_pilot = @best_lap_by_pilot.sort_by{ |l| l[:blap_time] }
  end

  def print_best_lap_by_pilot
    if @best_lap_by_pilot && !@best_lap_by_pilot.empty?
      Terminal::Table.new(title: "Pilots best LAP", headings: [ 'Pilot', 'LAP Number', 'Time'], rows: @best_lap_by_pilot.map{|p| p.values})
    else
      "Race results unprocessed. Please run step 2 before trying this"
    end
  end

  def get_race_best_lap
    @race_best_lap = @laps.sort_by{ |l| l.duration }.first
  end

  def print_race_best_lap
    if @race_best_lap
      Terminal::Table.new(title: "Race best LAP", headings: [ 'Pilot', 'LAP Number', 'Time'], rows: @race_best_lap.p_values)
    else
      "Race results unprocessed. Please run step 2 before trying this"
    end
  end

  def get_avg_speed
    @pilots.each do |p|
      @avg_speed << {name: p.name, laps_completed: p.laps_completed, avg_speed: p.avg_speed}
    end

    @avg_speed = @avg_speed.sort_by{ |a| a[:avg_speed] }.reverse
  end

  def print_avg_speed
    if @avg_speed && !@avg_speed.empty?
      Terminal::Table.new(title: "Race AVG Speed", headings: [ 'Pilot', 'LAPs completed', 'AVG Speed'], rows: @avg_speed.map{|a| a.values})
    else
      "Race results unprocessed. Please run step 2 before trying this"
    end
  end

end