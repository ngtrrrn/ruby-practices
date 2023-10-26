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

pins_of_tenth = frames.slice!(9..-1)
frame_of_tenth = []
pins_of_tenth.map do |pin|
  pin = [10] if pin == [10, 0]
  frame_of_tenth += pin
end
frames[9] = frame_of_tenth

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
