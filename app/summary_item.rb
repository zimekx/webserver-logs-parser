class SummaryItem
  attr_reader :key, :value

  def initialize(key, value)
    @key = key
    @value = value
  end

  # TODO:
  # reverse! would be faster but it's not stable
  # https://stackoverflow.com/questions/2642182/sorting-an-array-in-descending-order-in-ruby
  def sort_key
    -value
  end
end