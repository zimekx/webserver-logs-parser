require_relative 'page-views-recorder'
require 'set'

class UniquePageViewsRecorder < PageViewsRecorder
  def initialize
    @stats = Hash.new { |h, k| h[k] = Set.new }
  end

  def record(line)
    page_view = PageViewEntry.new(line)
    stats[page_view.page_path].add(page_view.user_ip)

    true
  end

  def print_stats
    Array(stats)
      .map { |page, user_ips_set| [page, user_ips_set.size]}
      .sort_by { |_page, unique_user_views| -unique_user_views }
      .each { |page, views| puts "#{page} #{views} unique views" }
  end
end