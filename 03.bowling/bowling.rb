#!/usr/bin/env ruby

require 'debug'

score = ARGV[0]
scores = score.split(',')

shots = []
scores.each do |s|
  if s == 'X'
    shots << 10
    shots << 0
  else
    shots << s.to_i
  end
end

frames = shots.each_slice(2).to_a

if ! frames[10].nil?
  if frames[9] == [10, 0]
    if frames[10] == [10, 0]
      frames[10][1] = frames[11][0]
      frames.pop
    end
    frames[9].pop
    frames[9] << frames[10][0]
    frames[9] << frames[10][1]

  else
    frames[9] << frames[10][0]
  end
  frames.pop
end

point = 0
frames_array_num = 0

frames.each do |frame|
  point += frame.sum 
  if frames_array_num <= 8 # 10フレーム目はスペア・ストライクボーナス無しのため除外
    if frame[0] == 10
      point += frames[frames_array_num + 1][0]
      if frames[frames_array_num + 1][0] == 10 && frames_array_num != 8 #9フレーム目のストライクは10フレーム目1•2投目を参照するため除外
        point += frames[frames_array_num + 2][0]
      else
        point += frames[frames_array_num + 1][1]
      end
    elsif frame.sum == 10
      point += frames[frames_array_num + 1][0]
    end
  end
  frames_array_num += 1  
end
puts point
