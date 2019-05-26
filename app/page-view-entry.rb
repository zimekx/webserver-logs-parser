class PageViewEntry
  attr_reader :page_path, :user_ip

  LOG_SHAPE = {
    page_path: 0,
    user_ip: 1
  }.freeze

  def initialize(line)
    log_info = line.split(' ')

    @page_path = log_info[LOG_SHAPE[:page_path]]
    @user_ip = log_info[LOG_SHAPE[:user_ip]]
  end
end