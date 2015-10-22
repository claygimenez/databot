module Databot
  module Cluster
    require 'matrix'

    extend self

    def kmeans(bucket_count, input_array)
      # 0. set stop criterion
      i = 3

      # 1. seed buckets
      buckets = {}
      # seeds = input_array.sample(bucket_count)
      seeds = [[0.0,1.0,2.0],[7.0,8.0,9.0]]

      seeds.each {|seed| buckets[seed] = []}

      # 2. assign elements to buckets
      buckets = assign_elements_to_buckets(input_array, buckets)

      (i-1).times do
        # 3. recalculate bucket centroids
        buckets = recalculate_bucket_centroids(buckets)

        # 2. assign elements to buckets
        buckets = assign_elements_to_buckets(input_array, buckets)
      end

      puts "!!!!!! #{buckets} !!!!!"
      input_array
    end

    private

    def assign_elements_to_buckets(elems, buckets)
      elems.each do |elem|
        # calculate optimal bucket for elem
        # default bucket to nil and distance to infinity
        closest_bucket = nil
        closest_distance = Float::INFINITY

        # puts "BUCKETS: #{buckets.keys}"
        buckets.each do |seed, bucket|
          current_distance = calculate_sq_euclidean_distance(elem, seed)
          puts "ELEM: #{elem}, SEED: #{seed}, DIST: #{current_distance}"

          if current_distance < closest_distance
            # update best fit variables
            closest_bucket = buckets[seed]
            closest_distance = current_distance
            # puts "BUCKETS: #{buckets}"
            # puts "updating distance--#{elem} is closest to #{seed}"
          else
            # puts "NOT UPDATING DISTANCE--current: #{current_distance} and closest: #{closest_distance}"
          end
        end

        # assign the element to the closest bucket
        closest_bucket.push(elem)
        # puts "closest bucket for #{elem} is #{closest_bucket}"
      end

      buckets
    end

    def recalculate_bucket_centroids(buckets)
      centroids = []
      buckets.each do |seed, bucket|
        size = bucket.length
        sum = Array.new(seed.length, 0)
        bucket.each do |ele|
          ele.each_with_index do |val, index|
            sum[index] += val
          end
        end

        if size > 0
          sum.map! { |ele| ele / size }
          centroids.push(sum)
        else
          centroids.push(seed)
        end
      end

      buckets = {}
      centroids.each {|centroid| buckets[centroid] = []}
      buckets
    end

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
