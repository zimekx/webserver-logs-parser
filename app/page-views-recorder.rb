require_relative 'page-view-entry'

class PageViewsRecorder
  attr_reader :stats

  def initialize
    @stats = Hash.new { |h, k| h[k] = 0 }
  end

  def record(line)
    page_view = PageViewEntry.new(line)
    stats[page_view.page_path] += 1

    true
  end
end