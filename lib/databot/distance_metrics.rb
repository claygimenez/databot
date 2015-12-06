module Databot
  module DistanceMetrics

    extend self

    def calculate_sq_euclidean_distance(vect1, vect2)
      size = vect1.length
      sum = 0.0
      i = 0

      while i < size
        sum += (vect2[i] - vect1[i])**2
        i += 1
      end

      sum
    end
  end
end
