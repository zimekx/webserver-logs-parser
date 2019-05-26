class FileReader
  def initialize(file_path)
    validate_file_path(file_path)

    @file_path = file_path
  end

  # TODO:
  # Use faster implementation
  # https://felipeelias.github.io/ruby/2017/01/02/fast-file-processing-ruby.html
  def each_line
    File.readlines(file_path).each do |line|
      yield line
    end
  end

  private

  attr_reader :file_path

  def validate_file_path(file_path)
    raise ArgumentError, "Missing file path" unless file_path
    raise ArgumentError, "Incorrect file path: #{file_path}" unless File.file?(file_path)
  end
end