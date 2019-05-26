require_relative '../log_entries/page_view_entry'

class LogRecorder
  def initialize
    raise NotImplementedError
  end

  def record(*args)
    raise NotImplementedError
  end

  def summary
    raise NotImplementedError
  end

  private

  attr_reader :stats
end