#!/usr/bin/env ruby

require_relative 'app/total-page-views-recorder'
require_relative 'app/unique-page-views-recorder'
require_relative 'app/logs_parser'

LogsParser.new(
  FileReader.new(ARGV[0]),
  PageViewEntry,
  [
    TotalPageViewsRecorder.new,
    UniquePageViewsRecorder.new
  ]
).run