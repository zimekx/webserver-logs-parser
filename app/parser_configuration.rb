class ParserConfiguration
  attr_reader :file_reader, :log_event_parser, :log_mapping_strategy, :log_event_recorders

  def initialize(file_reader, log_event_parser, log_mapping_strategy, log_event_recorders)
    @file_reader = file_reader
    @log_event_parser = log_event_parser
    @log_mapping_strategy = log_mapping_strategy
    @log_event_recorders = log_event_recorders
  end
end

class LogEventRecorder
  attr_reader :event_recorder, :summary_formatter

  def initialize(event_recorder, summary_formatter)
    @event_recorder = event_recorder
    @summary_formatter = summary_formatter
  end
end

class ParserConfigurationBuilder
  def initialize
    @log_event_recorders = []
  end

  def file_path(file_path)
    @file_path = file_path
    self
  end

  def file_reader(file_reader)
    raise ArgumentError if @file_path.nil?
    @file_reader = file_reader.new(@file_path)
    self
  end

  def log_event_parser(log_event_parser)
    @log_event_parser = log_event_parser
    self
  end

  def log_mapping_strategy(log_mapping_strategy)
    @log_mapping_strategy = log_mapping_strategy
    self
  end

  def log_event_recorder(event_recorder, summary_formatter)
    @log_event_recorders << LogEventRecorder.new(event_recorder, summary_formatter)
    self
  end

  # TODO: add validation
  def build
    ParserConfiguration.new(@file_reader, @log_event_parser, @log_mapping_strategy, @log_event_recorders)
  end
end