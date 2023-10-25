#!/usr/bin/env ruby

require "optparse"
require "date"

args = ARGV.getopts("y:m:")

arg_y = args["y"]
arg_m = args["m"]

if arg_y.nil?
    year = Date.today.year
else
    year = arg_y.to_i
    raise "year `#{arg_y}' not in range 1970..2100" if year < 1970 || year > 2100
end

if arg_m.nil?
    month = Date.today.month
else
    month = arg_m.to_i
    raise "#{arg_m} is neither a month number (1..12) nor a name" if month < 1 || month > 12
end

wday_of_first_day = Date.new(year, month, 1).wday
cal_view = ""
day = 1

cal_view += "   " * wday_of_first_day

wday = wday_of_first_day

last_day = Date.new(year, month, -1).day
(1..last_day).each do |day|
    cal_view += "\e[7m" if Date.new(year, month, day) == Date.today
    
    if day < 10
      cal_view += "#{day}".rjust(2) 
    else
      cal_view += "#{day}"
    end

    cal_view += "\e[0m" if Date.new(year, month, day) == Date.today

    day += 1
    wday += 1
    if wday != 7
        cal_view += " "
    else
        cal_view += "\n"
        wday = 0
    end
end

puts "      #{month}月 #{year}"
puts "日 月 火 水 木 金 土"
puts "#{cal_view}"
puts
