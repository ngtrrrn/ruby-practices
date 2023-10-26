#!/usr/bin/env ruby

require "optparse"
require "date"

args = ARGV.getopts("y:m:")

arg_y = args["y"]
arg_m = args["m"]

today = Date.today

if arg_y.nil?
  year = today.year
else
  year = arg_y.to_i
  raise "year `#{arg_y}' not in range 1970..2100" if year < 1970 || year > 2100
end

if arg_m.nil?
  month = today.month
else
  month = arg_m.to_i
  raise "#{arg_m} is neither a month number (1..12) nor a name" if month < 1 || month > 12
end

first_day = Date.new(year, month, 1)
cal_view = ""
cal_view += "   " * first_day.wday

last_day = Date.new(year, month, -1)

(first_day..last_day).each do |date|
  day_str = date.day.to_s

  cal_view += "\e[7m" if date == today
  cal_view += day_str.rjust(2) 
  cal_view += "\e[0m" if date == today

  if date.saturday?
    cal_view += "\n"
  else
    cal_view += " "
  end
end

puts "      #{month}月 #{year}"
puts "日 月 火 水 木 金 土"
puts cal_view
puts
