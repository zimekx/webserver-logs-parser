require_relative 'page-view-entry'

class PageViewsRecorder
  def initialize
    raise NotImplementedError
  end

  def record(page_view)
    raise NotImplementedError
  end

  def summary
    raise NotImplementedError
  end

  private

  attr_reader :stats
end