#!/usr/bin/env ruby

require_relative 'app/recorders/total_hits_recorder'
require_relative 'app/recorders/unique_hits_recorder'
require_relative 'app/logs_parser'
require_relative 'app/formatters/total_visits_formatter'
require_relative 'app/formatters/unique_views_formatter'
require_relative 'app/mapping_strategies/page_by_user_ip_strategy'
require_relative 'app/mapping_strategies/user_ip_by_page_strategy'

LogsParser.new(
  FileReader.new(ARGV[0]),
  PageViewEntry,
  UserIpByPageStrategy,
  [
    {recorder: TotalHitsRecorder.new, formatter: TotalVisitsFormatter},
    {recorder: UniqueHitsRecorder.new, formatter: UniqueViewsFormatter}
  ]
).run