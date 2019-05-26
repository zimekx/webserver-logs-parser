class LogsParser
  def initialize(file_name)
    @file_name = file_name
    @page_views = Hash.new { |hash, key| hash[key] = 0 }
  end

  def run
    File.open(file_name).readlines.each do |line|
      page, _ip = line.split(' ')
      page_views[page] += 1
    end

    Array(page_views).sort_by { |_page, views| -views }.each do |page, views|
      puts "#{page} #{views} visits"
    end
  end

  private

  attr_reader :file_name, :page_views
end