require_relative 'file-reader'
require_relative 'total-page-views-recorder'

class LogsParser
  def initialize(file_path)
    @file_reader = FileReader.new(file_path)
    @page_views_recorder = TotalPageViewsRecorder.new
  end

  def run
    file_reader.each_line do |line|
      page_views_recorder.record(line)
    end

    page_views_recorder.print_stats
  end

  private

  attr_reader :file_reader, :page_views_recorder
end