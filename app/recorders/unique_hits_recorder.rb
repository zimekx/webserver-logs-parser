require_relative 'log_recorder'
require_relative '../summary_item'
require 'set'

class UniqueHitsRecorder < LogRecorder
  def initialize
    @stats = Hash.new { |h, k| h[k] = Set.new }
  end

  def record(key, value)
    stats[key].add(value)

    true
  end

  def summary
    Array(stats)
      .map { |key, values_set| SummaryItem.new(key, values_set.size) }
      .sort_by(&:sort_key)
  end
end
