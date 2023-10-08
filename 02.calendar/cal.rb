require "optparse"
require "date"

# カレンダーで表示する対象となる年と月を引数から取得
args = ARGV.getopts("y:m:")

# 年を決定
if ! args["y"].nil?
    year = args["y"].to_i
else
    year = Date.today.year
end

# 月を決定
if ! args["m"].nil?
    month = args["m"].to_i
else
    month = Date.today.month
end

# カレンダーのヘッダー
puts "      #{month}月 #{year}"
puts "日 月 火 水 木 金 土"

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
        
    # 今日の日付の場合は、文字色・背景色反転終了
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

puts "#{cal_view}"