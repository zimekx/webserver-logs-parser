require_relative 'page-view-entry'

class PageViewsRecorder
  def initialize
    raise NotImplementedError
  end

  def record(line)
    raise NotImplementedError
  end

  def print_stats
    raise NotImplementedError
  end

  private

  attr_reader :stats
end