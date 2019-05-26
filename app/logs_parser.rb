require_relative 'file-reader'

class LogsParser
  def initialize(file_path)
    @file_reader = FileReader.new(file_path)
    @page_views = Hash.new { |hash, key| hash[key] = 0 }
  end

  def run
    file_reader.each_line do |line|
      page, _ip = line.split(' ')
      page_views[page] += 1
    end

    Array(page_views).sort_by { |_page, views| -views }.each do |page, views|
      puts "#{page} #{views} visits"
    end
  end

  private

  attr_reader :file_reader, :page_views
end