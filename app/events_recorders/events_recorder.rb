require_relative '../log_events/page_view_event'

class EventsRecorder
  def record(*args)
    raise NotImplementedError
  end

  def summary
    raise NotImplementedError
  end

  private

  attr_reader :stats
end