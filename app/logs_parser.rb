require_relative 'file-reader'
require_relative 'page-views-recorder'

class LogsParser
  def initialize(file_path)
    @file_reader = FileReader.new(file_path)
    @page_views_recorder = PageViewsRecorder.new
  end

  def run
    file_reader.each_line do |line|
      page_views_recorder.record(line)
    end

    Array(page_views_recorder.stats).sort_by { |_page, views| -views }.each do |page, views|
      puts "#{page} #{views} visits"
    end
  end

  private

  attr_reader :file_reader, :page_views_recorder
end