require_relative 'page-views-recorder'
require 'set'

class UniquePageViewsRecorder < PageViewsRecorder
  def initialize
    @stats = Hash.new { |h, k| h[k] = Set.new }
  end

  def record(page_view)
    stats[page_view.page_path].add(page_view.user_ip)

    true
  end

  def summary
    Array(stats)
      .map { |page, user_ips_set| UniquePageViewSummaryItem.new(page, user_ips_set.size) }
      .sort_by(&:sort_key)
  end
end

class UniquePageViewSummaryItem
  attr_reader :page, :unique_views

  def initialize(page, unique_views)
    @page = page
    @unique_views = unique_views
  end

  def sort_key
    -unique_views
  end

  def to_s
    "#{page} #{unique_views} unique views"
  end
end