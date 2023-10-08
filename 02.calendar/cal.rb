require "optparse"
require "date"

# カレンダーで表示する対象となる年と月を引数から取得
args = ARGV.getopts("y:m:")

arg_y = args["y"]
arg_m = args["m"]

# 年を決定
if ! arg_y.nil?
    year = arg_y.to_i
    # 年の指定が不適切の場合、エラーを表示
    raise ScriptError, "year `#{arg_y}' not in range 1970..2100" if year < 1970 || year > 2100
else
    year = Date.today.year
end

# 月を決定
if ! arg_m.nil?
    month = arg_m.to_i
    # 月の指定が不適切の場合、エラーを表示
    raise ScriptError, "#{arg_m} is neither a month number (1..12) nor a name" if month < 1 || month > 12
else
    month = Date.today.month
end

# カレンダーの中身
wday_of_day01 = Date.new(year, month, 1).wday
cal_view = ""
day = 1

# 1日目が何曜日かで、開始曜日を調整
wday_of_day01.times do
    cal_view += "   "
end

wday = wday_of_day01

while day <= Date.new(year, month, -1).day do
    # 今日の日付の場合は、文字色・背景色反転開始
    cal_view += "\e[7m" if Date.new(year, month, day) == Date.today
    
    cal_view += " " if day < 10
    cal_view += "#{day}"
        
    # 文字色・背景色反転終了
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

# カレンダーの表示
puts "      #{month}月 #{year}"
puts "日 月 火 水 木 金 土"
puts "#{cal_view}"
puts "\n"