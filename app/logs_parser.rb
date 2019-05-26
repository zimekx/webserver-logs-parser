require_relative 'file-reader'
require_relative 'log_events/page_view_event'

class LogsParser
  def initialize(parser_configuration)
    @file_reader = parser_configuration.file_reader
    @log_event_parser = parser_configuration.log_event_parser
    @mapping_strategy = parser_configuration.log_mapping_strategy
    @log_event_recorders = parser_configuration.log_event_recorders
  end

  def run
    analyze_logs
    print_summaries
  end

  private

  def analyze_logs
    file_reader.each_line do |line|
      log_event = log_event_parser.from(line)
      mapping = mapping_strategy.new(log_event)
      log_event_recorders.each do |log_event_recorder|
        log_event_recorder.event_recorder.record(mapping.key, mapping.value)
      end
    end
  end

  def print_summaries
    log_event_recorders.each do |log_event_recorder|
      log_event_recorder.event_recorder.summary.each do |summary_item|
        puts log_event_recorder.summary_formatter.new(summary_item)
      end
    end
  end

  attr_reader :file_reader, :log_event_recorders, :log_event_parser, :mapping_strategy
end