require 'test/unit'
require_relative '../lib/lap.rb'
require_relative '../lib/processor.rb'

class LapTest < Test::Unit::TestCase

  def setup
    race_results_path = File.expand_path('test/resources/RaceResultsTest.txt')
    @processor = Processor.new(race_results_path)
    @processor.process
  end

  def test_duration_in_seconds
    assert_equal 60, @processor.laps[0].duration_in_seconds
    assert_equal 90, @processor.laps[1].duration_in_seconds 
  end

  def test_p_values
    lap = @processor.laps.first
    expected = [['R.BARRICHELLO', '1', '1:00.000']]
    assert_equal expected, lap.p_values
  end
end