require 'spec_helper'

describe 'Databot::Cluster.kmeans' do
  it 'has connected pipes!' do
    input = [[0.0,1.0,2.0], [0.0,1.0,2.0], [7.0,8.0,9.0], [7.0,8.0,9.0]]
    expect(Databot::Cluster.kmeans(2, input)).to eq(input)
  end
end
