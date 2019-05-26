class PageViewEntry
  LOG_SHAPE = {
    page_path: 0,
    user_ip: 1
  }.freeze

  def self.from(line)
    log_info = line.split(' ')

    page_path = log_info[LOG_SHAPE[:page_path]]
    user_ip = log_info[LOG_SHAPE[:user_ip]]

    new(page_path, user_ip)
  end

  attr_reader :page_path, :user_ip

  def initialize(page_path, user_id)
    @page_path = page_path
    @user_ip = user_id
  end
end