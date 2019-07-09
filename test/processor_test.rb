require 'test/unit'
require_relative '../lib/lap.rb'
require_relative '../lib/processor.rb'

class ProcessorTest < Test::Unit::TestCase

  def setup
    expected_vars
    race_results_path = File.expand_path('test/resources/RaceResultsTest.txt')
    @processor = Processor.new(race_results_path)
  end

  def test_get_laps_and_pilots
    @processor.get_laps_and_pilots

    assert_equal @pilots_expected.size, @processor.pilots.size
    assert_equal @laps_expected.size, @processor.laps.size
  end

  def test_get_race_results
    @processor.get_laps_and_pilots
    @processor.get_race_results

    assert_equal @race_results_expected, @processor.race_results
  end

  def test_get_best_lap_by_pilot
    @processor.get_laps_and_pilots
    @processor.get_best_lap_by_pilot

    assert_equal @best_lap_by_pilot_expected, @processor.best_lap_by_pilot
  end

  def test_get_race_best_lap
    @processor.get_laps_and_pilots
    @processor.get_race_best_lap

    assert_equal @race_best_lap_expected.time, @processor.race_best_lap.time 
    assert_equal @race_best_lap_expected.pilot_id, @processor.race_best_lap.pilot_id 
    assert_equal @race_best_lap_expected.pilot_name, @processor.race_best_lap.pilot_name 
    assert_equal @race_best_lap_expected.number, @processor.race_best_lap.number
    assert_equal @race_best_lap_expected.duration, @processor.race_best_lap.duration 
    assert_equal @race_best_lap_expected.avg_speed, @processor.race_best_lap.avg_speed
  end

  def test_get_avg_speed
    @processor.get_laps_and_pilots
    @processor.get_avg_speed

    assert_equal @avg_speed_expected, @processor.avg_speed
  end

  private

  def expected_vars

    laps_from_file = File.readlines(File.expand_path('test/resources/RaceResultsTest.txt'))

    @laps_expected = []
    @pilots_expected = []

    laps_from_file.each do |l|
      @laps_expected << Lap.new(l)        
    end

    @laps_expected.group_by{|l| l.pilot_id}.each do |p_id, laps|
      @pilots_expected << Pilot.new(p_id, laps)
    end

    @race_results_expected = [
      {position: 1, p_id: '002', p_name: 'K.RAIKKONEN', qtd_lap: 4, total_time: '4:41.045'},
      {position: 2, p_id: '033', p_name: 'R.BARRICHELLO', qtd_lap: 4, total_time: '4:51.728'}
    ]

    @best_lap_by_pilot_expected = [
      {:name=>"R.BARRICHELLO", :blap_number=>"1", :blap_time=>"1:00.000"},
      {:name=>"K.RAIKKONEN", :blap_number=>"4", :blap_time=>"1:03.076"}
    ]

    @race_best_lap_expected = @laps_expected.first

    @avg_speed_expected = [
      {:name=>"K.RAIKKONEN", :laps_completed=>4, :avg_speed=>43.627},
      {:name=>"R.BARRICHELLO", :laps_completed=>4, :avg_speed=>43.468}
    ]

  end
end



