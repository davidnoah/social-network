require 'set'

class Social_Network
  attr_reader :word, :dictionary, :alpha
  attr_accessor :count

  def initialize(word, dictionary)
    @words_queue = [word]
    @dictionary = build_dictionary(dictionary)
    @alpha = ("A".."Z").to_a
    @seen = Set.new.add(word)
  end

  def size
    until @words_queue.empty?
      count_friends(@words_queue.shift)
    end
    @seen.size
  end

  def count_friends(current_word)
    current_word.length.times do |idx|
      check_deletion(idx, current_word)
      check_addition(idx, current_word)
      check_substitution(idx, current_word)
    end
  end

  def check_deletion(index, current_word)
    length = current_word.length
    temp = current_word[0...index] + current_word[(index + 1)...length]
    check_dictionary(temp)
  end

  def check_addition(index, current_word)
    length = current_word.length
    alpha.each do |letter|
      temp = current_word[0, index] + letter + current_word[index...length]
      check_dictionary(temp)

      if index == (current_word.length - 1)
        temp = current_word + letter
        check_dictionary(temp)
      end
    end
  end

  def check_substitution(index, current_word)
    length = current_word.length
    alpha.each do |letter|
      temp = current_word[0...index] + letter + current_word[(index + 1)...length]
      check_dictionary(temp)
    end
  end

  def check_dictionary(temp)
    if dictionary.include?(temp) && !@seen.include?(temp)
      @words_queue << temp
      @seen.add(temp)
    end
  end

  def build_dictionary(dictionary)
    set = Set.new
    File.readlines(dictionary).each do |line|
      set.add(line.chomp)
    end
    set
  end

end

p Social_Network.new('LISTY', 'dict/very_small_test_dictionary.txt').size
