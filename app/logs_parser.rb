require_relative 'file-reader'
require_relative 'page-view-entry'

class LogsParser
  def initialize(file_reader, page_view_entry_class, page_views_recorders)
    @file_reader = file_reader
    @page_view_entry_class = page_view_entry_class
    @page_views_recorders = page_views_recorders
  end

  def run
    file_reader.each_line do |line|
      page_view = page_view_entry_class.from(line)
      page_views_recorders.each { |recorder| recorder.record(page_view) }
    end

    page_views_recorders.each do |recorder|
      recorder.summary.each do |summary_item|
        puts summary_item
      end
    end
  end

  private

  attr_reader :file_reader, :page_views_recorders, :page_view_entry_class
end