#!/usr/bin/env ruby

# 引数をとる
score = ARGV[0]
scores = score.split(',')

# 数字に変換
shots = []
scores.each do |s|
    if s == 'X' # strike
        shots << 10
        shots << 0
    else
        shots << s.to_i
    end
end

# 2フレームごとに分割する
frames = []
shots.each_slice(2) do |s|
    frames << s
end

# 得点を合計する
point = 0
frames.each do |frame|
    if frame[0] == 10 # strike
      point += 30
    elsif frame.sum == 10 # spare
      point += frame[0] + 10
    else
      point += frame.sum
    end
  end
  puts point