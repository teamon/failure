#!/usr/bin/env ruby
$:.unshift File.expand_path File.join File.dirname(__FILE__), 'lib'

require 'securerandom'
require 'helper'
require 'random'

print_usage if ARGV.size < 5

TIME_MAX, K, K_MAX, K_MIN, ALGORITHM = ARGV.map {|v| v.to_i}
KS = K.times.to_a

mag = Array.new(K) { K_MAX }
time = 0
profit = 0

case ALGORITHM
when 0
  lambda_check = ->(val, time) { val <= K_MIN }
  lambda_set = ->(k) { mag[k] = K_MAX }
when 1
  lambda_check = ->(val, time) { val <= (K_MIN/100.0 * K_MAX) }
  lambda_set = ->(k) { mag[k] *= 2 }
when 2
  lambda_check = ->(val, time) { (0..1).include? time % K_MIN }
  lambda_set = ->(k) { mag[k] = K_MAX }
end

print_header mag
print_time_and_mag time, mag, profit

while time < TIME_MAX
  time += Math::exprnd

  KS.sample(Math::random(K)).each do |k|
    unless mag[k] == 0
      mag[k] -= 1
      profit += k
    else
      profit -= k
    end
  end

  mag.each_with_index do |v, i|
    before = mag[i]
    lambda_set[i] if lambda_check[v, time]
    profit -= i * (mag[i] - before)
  end

  print_time_and_mag time, mag, profit
end

puts profit

