require 'set'

class Social_Network
  def initialize(word, dictionary)
    @word = word
    @dictionary = build_dictionary(dictionary)
  end

  def size
    
  end

  def build_dictionary(dictionary)
    set = Set.new
    File.readlines(dictionary).each do |line|
      set.add(line.chomp)
    end
    set
  end
end

p Social_Network.new('LISTY', 'dict/very_small_test_dictionary.txt')
