#!/usr/bin/env ruby

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

tmp_frames = shots.each_slice(2).to_a
last_pins = tmp_frames.slice(9..-1)
last_frame = []
last_pins.map do |pin|
  pin = [10] if pin == [10, 0]
  last_frame += pin
end
frames = [*tmp_frames.slice(0..8), last_frame]


point = 0
frames.each_with_index do |current_frame, idx|
  point += current_frame.sum 
  break if idx == 9 # 10フレーム目はスペア・ストライクボーナス無しのため除外
  next_frame = frames[idx + 1]
  after_next_frame = frames[idx + 2]
  if current_frame[0] == 10
    point += next_frame[0]
    if next_frame[0] == 10 && idx != 8 # 9フレーム目のストライクは10フレーム目1•2投目を参照するため除外
      point += after_next_frame[0]
    else
      point += next_frame[1]
    end
  elsif current_frame.sum == 10
    point += next_frame[0]
  end
end
puts point
