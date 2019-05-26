class SummaryItemFormatter
  def initialize(summary_item)
    @summary_item = summary_item
  end

  def to_s
    raise NotImplementedError
  end

  private

  attr_reader :summary_item
end