require 'set'

class Social_Network
  attr_reader :word, :dictionary, :alpha
  attr_accessor :count

  def initialize(dictionary)
    @dictionary = build_dictionary(dictionary)
    @alpha = ("A".."Z").to_a
  end

  # The workhorse of our program. Size takes in any word and returns the size of
  # it's social network.
  def size(word)
    @words_queue = [word]
    @seen = Set.new.add(word)
    until @words_queue.empty?
      count_friends(@words_queue.shift)
    end
    @seen.size
  end

  # Assesses single character edits (insertions, deletions, substitutions)
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

  # Checks if our curret word is within the dictionary and adds the word to our
  # queue and seen words hash
  def check_dictionary(temp)
    if dictionary.include?(temp) && !@seen.include?(temp)
      @words_queue << temp
      @seen.add(temp)
    end
  end

  # Initializes a new set and constructs the dictionary to ensure constant lookup
  def build_dictionary(dictionary)
    set = Set.new
    File.readlines(dictionary).each do |line|
      set.add(line.chomp)
    end
    set
  end

end

p Social_Network.new('dict/dictionary.txt').size("LISTY")
