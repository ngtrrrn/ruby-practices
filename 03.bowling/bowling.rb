require 'debug'

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

# 10フレーム目は2投もしくは3投でカウント
if ! frames[10].nil?
    frames[9] << frames[10][0]
    frames.pop
end

# 得点を合計する
point = 0
frames_array_num = 0
frames.each do |frame|
    point += frame.sum 
    if frames_array_num <= 8 # 10フレーム目はスペア・ストライクボーナス無し
        if frame[0] == 10 # strike
            point += frames[frames_array_num + 1][0]
            if frames[frames_array_num + 1][0] == 10
                point += frames[frames_array_num + 2][0]
            else
                point += frames[frames_array_num+1][1]
            end
        elsif frame.sum == 10 # spare
            point += frames[frames_array_num+1][0]
        end
    end
    frames_array_num += 1
  end
  puts point