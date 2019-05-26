require_relative 'mapping_strategy'

class UserIpByPageStrategy < MappingStrategy
  def initialize(page_view)
    @key = page_view.user_ip
    @value = page_view.page_path
  end
end