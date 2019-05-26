class UserIpByPageStrategy
  attr_reader :key, :value

  def initialize(page_view)
    @key = page_view.user_ip
    @value = page_view.page_path
  end
end