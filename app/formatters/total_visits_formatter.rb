require_relative 'summary_item_formatter'

class TotalVisitsFormatter < SummaryItemFormatter
  def to_s
    "#{summary_item.key} #{summary_item.value} visits"
  end
end