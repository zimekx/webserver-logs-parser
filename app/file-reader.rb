class FileReader
  def initialize(file_path)
    @file_path = file_path
  end

  def each_line
    File.readlines(file_path).each do |line|
      yield line
    end
  end

  private

  attr_reader :file_path
end