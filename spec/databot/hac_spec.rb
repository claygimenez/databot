require 'spec_helper'

describe 'Databot::Cluster.hac' do
  it 'has connected pipes!' do
    expect(Databot::Cluster.hac).to eq('hi')
  end
end
