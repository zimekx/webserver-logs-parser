require_relative 'page-views-recorder'

class TotalPageViewsRecorder < PageViewsRecorder
  def initialize
    @stats = Hash.new { |h, k| h[k] = 0 }
  end

  def record(line)
    page_view = PageViewEntry.new(line)
    stats[page_view.page_path] += 1

    true
  end

  def print_stats
    Array(stats).sort_by { |_page, views| -views }.each do |page, views|
      puts "#{page} #{views} visits"
    end
  end
end