require_relative 'file-reader'

class LogsParser
  def initialize(file_path, page_views_recorders)
    @file_reader = FileReader.new(file_path)
    @page_views_recorders = page_views_recorders
  end

  def run
    file_reader.each_line do |line|
      page_views_recorders.each { |recorder| recorder.record(line) }
    end

    page_views_recorders.each { |recorder| recorder.print_stats }
  end

  private

  attr_reader :file_reader, :page_views_recorders
end