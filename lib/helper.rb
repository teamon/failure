def print_usage
  puts "Usage: gen.rb TIME K K_MAX K_MIN ALGORITHM"
  exit 1
end

def print_header(mag)
  print "           Time | "
  (1..mag.size).each {|i| print "% 4d " % i }
  puts
  puts "-" * (17+mag.size*5)
end

def print_time_and_mag time, mag, profit
  print "% 15f | " % time
  mag.each {|e| print "% 4d " % e }
  puts " | #{profit}"
end
