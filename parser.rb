#!/usr/bin/env ruby

require_relative 'app/events_recorders/total_hits_recorder'
require_relative 'app/events_recorders/unique_hits_recorder'
require_relative 'app/logs_parser'
require_relative 'app/formatters/total_visits_formatter'
require_relative 'app/formatters/unique_views_formatter'
require_relative 'app/mapping_strategies/page_by_user_ip_strategy'
require_relative 'app/mapping_strategies/user_ip_by_page_strategy'
require_relative 'app/parser_configuration'

parser_configuration = ParserConfigurationBuilder.new
  .file_path(ARGV[0])
  .file_reader(FileReader)
  .log_event_parser(PageViewEvent)
  .log_mapping_strategy(PageByUserIpStrategy)
  .log_event_recorder(TotalHitsRecorder.new, TotalVisitsFormatter)
  .log_event_recorder(UniqueHitsRecorder.new, UniqueViewsFormatter)
  .build()

LogsParser.new(parser_configuration).run