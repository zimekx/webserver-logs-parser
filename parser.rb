#!/usr/bin/env ruby

require_relative 'app/logs_parser'

LogsParser.new(ARGV[0]).run