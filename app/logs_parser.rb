class LogsParser
  def initialize(file_name)
    @file_name = file_name
  end

  def run
    puts "Running logs parser for #{file_name}"
  end

  private

  attr_reader :file_name
end