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

frames_tmp = shots.each_slice(2).to_a

pins_of_tenth = frames_tmp.slice(9..-1)
frame_of_tenth = []

pins_of_tenth.map do |pin|
  pin = [10] if pin == [10, 0]
  frame_of_tenth += pin
end
frames = frames_tmp.slice(0..8)
frames.push(frame_of_tenth)

point = 0

frames.each_with_index do |frame, idx|
  point += frame.sum 
  if idx <= 8 # 10フレーム目はスペア・ストライクボーナス無しのため除外
    next_frame = idx + 1
    after_next_frame = idx + 2
    if frame[0] == 10
      point += frames[next_frame][0]
      if frames[next_frame][0] == 10 && idx != 8 #9フレーム目のストライクは10フレーム目1•2投目を参照するため除外
        point += frames[after_next_frame][0]
      else
        point += frames[next_frame][1]
      end
    elsif frame.sum == 10
      point += frames[next_frame][0]
    end
  end
end
puts point
