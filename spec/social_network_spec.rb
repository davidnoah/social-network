require 'rspec'
require_relative '../social_network.rb'

describe Social_Network do
  let(:network) { Social_Network.new('./dict/very_small_test_dictionary.txt') }

  describe '#size' do
    it 'returns an integer' do
      expect(network.size("LISTY")).to be(5)
    end

    it 'input can be all lowercase' do
      expect(network.size("listy")).to eq(5)
    end

    it 'raises error if non-letter chars are passed in' do
      expect do
        network.size("LIS6TY")
      end.to raise_error("Your word must only contain letters")
    end

    it 'raises error if empty sting is passed in' do
      expect do
        network.size("")
      end.to raise_error("Your word must only contain letters")
    end

    it 'can assess multiple word for the same instance' do
      expect(network.size("LIST")).to eq(7)
      expect(network.size("LISTY")).to eq(5)
    end
  end

  describe '#dictionary' do
    it 'can be an array' do
      expect(Social_Network.new(["hi"]).dictionary.include?("HI")).to be(true)
    end

    it 'can pass in a .txt file' do
      expect(Social_Network.new('./dict/very_small_test_dictionary.txt').dictionary.include?("LIT")).to be(true)
    end

    it 'raise an error if invalid dictionary is used' do
      expect do
        Social_Network.new(3)
      end.to raise_error("Your dictionary must be a .txt file or an array")
    end
  end
end
