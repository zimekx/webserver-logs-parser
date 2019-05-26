class PageViewEvent
  LOG_SHAPE = {
    page_path: 0,
    user_ip: 1
  }.freeze

  LOG_FIELDS_SEPARATOR = ' '.freeze

  def self.from(line)
    log_fields = line.split(LOG_FIELDS_SEPARATOR)

    page_path = log_fields[LOG_SHAPE[:page_path]]
    user_ip = log_fields[LOG_SHAPE[:user_ip]]

    new(page_path, user_ip)
  end

  attr_reader :page_path, :user_ip

  def initialize(page_path, user_ip)
    @page_path = page_path
    @user_ip = user_ip
  end
end