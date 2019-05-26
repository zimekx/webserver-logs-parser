require_relative 'summary_item_formatter'

class UniqueViewsFormatter < SummaryItemFormatter
  def to_s
    "#{summary_item.key} #{summary_item.value} unique views"
  end
end