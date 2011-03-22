#!/usr/bin/env ruby

require 'securerandom'

if ARGV.size <  3
  puts "Usage: #{__FILE__} TIME K K_MAX"
  exit 1
end


def rand(n = 1)
  (SecureRandom.random_number * n).to_i
end

def exprnd(l)
  l * Math::E ** (-l * SecureRandom.random_number)
end

def print_header(mag)
  print "           Time | "
  (1..mag.size).each {|i| print "% 4d " % i }
  puts
  puts "-" * (17+mag.size*5)
end

def print_time_and_mag(time, mag)
  print "% 15f | " % time
  mag.each {|e| print "% 4d " % e }
  puts
end


TIME_MAX = ARGV[0].to_i
K = ARGV[1].to_i
K_MAX = ARGV[2].to_i

KS = K.times.to_a

mag = Array.new(K) { rand(K_MAX) }
time = 0

print_header(mag)
print_time_and_mag(time, mag)

while time < TIME_MAX
  time += exprnd(1)
  
  KS.sample(rand(K)).each do |k|
    mag[k] -= 1 if mag[k] >= 1
  end
  
  print_time_and_mag(time, mag)
end
