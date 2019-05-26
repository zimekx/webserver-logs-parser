class PageByUserIpStrategy
  attr_reader :key, :value

  def initialize(page_view)
    @key = page_view.page_path
    @value = page_view.user_ip
  end
end