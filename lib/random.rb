require 'securerandom'

module Math
  class << self
    def random n = nil
      if n.is_a? Range
        min, max = n.first, n.last
        min + SecureRandom.random_number(max - min + 1)
      elsif n != nil
        SecureRandom.random_number n
      else
        SecureRandom.random_number
      end
    end

    def exprnd l = 1
      l * E ** (-l * random)
    end
  end
end

