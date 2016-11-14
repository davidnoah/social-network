require 'set'

class Social_Network
  attr_reader :length, :word, :dictionary, :alpha
  attr_accessor :count

  def initialize(word, dictionary)
    @word = word
    @dictionary = build_dictionary(dictionary)
    @length = word.length
    @alpha = ("A".."Z").to_a
    @count = 0
    @words_queue = [word]
    @seen = Set.new.add(word)
  end

  def size
    until @words_queue.empty?
      p @words_queue
      check_count(@words_queue.shift)
    end
    @count
  end

  def check_count(current_word)
    current_word.length.times do |idx|
      check_deletion(idx, current_word)
      check_addition(idx, current_word)
      check_substitution(idx, current_word)
    end
  end

  def check_deletion(index, current_word)
      temp = current_word[0...index] << current_word[(index + 1)...length]
      check_dictionary(temp)
  end

  def check_addition(index, current_word)
    alpha.each do |letter|
      temp = current_word[0, index] + letter + current_word[index...length]
      check_dictionary(temp)

      if index == (length - 1)
        temp = current_word + letter
        check_dictionary(temp)
      end
    end
  end

  def check_substitution(index, current_word)
    alpha.each do |letter|
      temp = current_word[0...index] << letter << current_word[(index + 1)...length]
      check_dictionary(temp)
    end
  end

  def check_dictionary(temp)
    if dictionary.include?(temp) && !@seen.include?(temp)
      @words_queue << temp
      @count += 1
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
