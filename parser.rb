#!/usr/bin/env ruby

require_relative 'app/total-page-views-recorder'
require_relative 'app/unique-page-views-recorder'
require_relative 'app/logs_parser'

LogsParser.new(ARGV[0], [TotalPageViewsRecorder.new, UniquePageViewsRecorder.new]).run