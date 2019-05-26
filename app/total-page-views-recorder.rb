require_relative 'page-views-recorder'

class TotalPageViewsRecorder < PageViewsRecorder
  def initialize
    @stats = Hash.new { |h, k| h[k] = 0 }
  end

  def record(page_view)
    stats[page_view.page_path] += 1

    true
  end

  def summary
    Array(stats)
      .map { |page, views| TotalPageViewSummaryItem.new(page, views) }
      .sort_by(&:sort_key)
  end
end

class TotalPageViewSummaryItem
  attr_reader :page, :views

  def initialize(page, views)
    @page = page
    @views = views
  end

  def sort_key
    -views
  end

  def to_s
    "#{page} #{views} visits"
  end
end