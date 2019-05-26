require_relative 'mapping_strategy'

class PageByUserIpStrategy < MappingStrategy
  def initialize(page_view)
    @key = page_view.page_path
    @value = page_view.user_ip
  end
end