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

      (i - 1).times do
        # 3. recalculate bucket centroids
        buckets = recalculate_bucket_centroids(buckets)

        # 2. assign elements to buckets
        buckets = assign_elements_to_buckets(input_array, buckets)
      end

      input_array
    end

    private

    def assign_elements_to_buckets(elems, buckets)
      elems.each do |elem|
        # calculate optimal bucket for elem
        # default bucket to nil and distance to infinity
        closest_bucket = nil
        closest_distance = Float::INFINITY

        buckets.each do |seed, bucket|
          current_distance = Databot::DistanceMetrics.calculate_sq_euclidean_distance(elem, seed)

          if current_distance < closest_distance
            # update best fit variables
            closest_bucket = buckets[seed]
            closest_distance = current_distance
          end
        end

        # assign the element to the closest bucket
        closest_bucket.push(elem)
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

  end
end
