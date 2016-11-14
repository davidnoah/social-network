require 'set'

class Social_Network
  attr_reader :word, :dictionary, :alpha
  attr_accessor :count

  def initialize(dictionary)
    # Type check to account for a .txt file or an Array
    @dictionary = dictionary.is_a?(String) ? build_dictionary(dictionary) : dictionary
    @alpha = ("A".."Z").to_a
  end

  # The workhorse of our program. Size takes in any word and returns the size of
  # it's social network. Implements Breadth First Search with a queue. Words are
  # assessed as they are shifted off and "friends" are pushed to the end of the
  # queue once they are found.
  def size(word)
    @words_queue = [word]
    @seen = Set.new.add(word)
    until @words_queue.empty?
      count_friends(@words_queue.shift)
    end
    @seen.size
  end

  # Assesses single character edits (insertions, deletions, substitutions) for
  # each index
  def count_friends(current_word)
    current_word.length.times do |idx|
      check_deletion(idx, current_word)
      check_addition(idx, current_word)
      check_substitution(idx, current_word)
    end
  end

  # Builds a new word with the character at our current index removed and checks
  # for vailidity within the dictionary
  def check_deletion(index, current_word)
    length = current_word.length
    temp = current_word[0...index] + current_word[(index + 1)...length]
    check_dictionary(temp)
  end

  # Builds a new word with each letter of the alphabet added to the left of the
  # character at our current index except for the last letter in our word. In this
  # case we assess both left and right positions.
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

  # Substitutes our current letter with every letter in the alphabet and checks
  # for validity within the dictionary
  def check_substitution(index, current_word)
    length = current_word.length
    alpha.each do |letter|
      temp = current_word[0...index] + letter + current_word[(index + 1)...length]
      check_dictionary(temp)
    end
  end

  # Checks if our current word is within the dictionary and adds the word to our
  # queue and seen words hashmap
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
