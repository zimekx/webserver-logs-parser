require_relative 'log_recorder'
require_relative '../summary_item'

class TotalHitsRecorder < LogRecorder
  def initialize
    @stats = Hash.new { |h, k| h[k] = 0 }
  end

  def record(key, value)
    stats[key] += 1

    true
  end

  def summary
    Array(stats)
      .map { |key, total_hits| SummaryItem.new(key, total_hits) }
      .sort_by(&:sort_key)
  end
end