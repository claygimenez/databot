require 'spec_helper'

describe Databot::DistanceMetrics do
  it 'calculates squared euclidean distance (integers)' do
    vect1 = [0, 1, 2]
    vect2 = [3, 3, 3]
    result = 14.0
    expect(Databot::DistanceMetrics.calculate_sq_euclidean_distance(vect1, vect2)).to eq(result)
  end

  it 'calculates squared euclidean distance (floats)' do
    vect1 = [20.7, 0.0, 2.5]
    vect2 = [13.0, 6.2, 1.0]
    result = 99.98
    expect(Databot::DistanceMetrics.calculate_sq_euclidean_distance(vect1, vect2)).to be_within(0.01).of(result)
  end
end
