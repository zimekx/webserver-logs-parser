require_relative 'file-reader'
require_relative 'log_entries/page_view_entry'

class LogsParser
  def initialize(file_reader, log_entry_parser, mapping_strategy, log_recorders)
    @file_reader = file_reader
    @log_entry_parser = log_entry_parser
    @mapping_strategy = mapping_strategy
    @log_recorders = log_recorders
  end

  def run
    analyze_logs
    print_summaries
  end

  private

  def analyze_logs
    file_reader.each_line do |line|
      log_entry = log_entry_parser.from(line)
      mapping = mapping_strategy.new(log_entry)
      log_recorders.each do |handler|
        handler[:recorder].record(mapping.key, mapping.value)
      end
    end
  end

  def print_summaries
    log_recorders.each do |handler|
      handler[:recorder].summary.each do |summary_item|
        puts handler[:formatter].new(summary_item)
      end
    end
  end

  attr_reader :file_reader, :log_recorders, :log_entry_parser, :mapping_strategy
end