TIMES = 10
TIME = 10_000
K = 10
K_MAX = 400
K_MIN = [20, 10, 40]

3.times do |alg|
  TIMES.times do
    puts `ruby gen.rb #{TIME} #{K} #{K_MAX} #{K_MIN[alg]} #{alg} | tail -1`
  end
  print "\n"
end
