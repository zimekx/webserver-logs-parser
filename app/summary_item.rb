class SummaryItem
  attr_reader :key, :value

  def initialize(key, value)
    @key = key
    @value = value
  end

  def sort_key
    -value
  end
end