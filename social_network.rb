require 'set'

class Social_Network
  attr_reader :word, :dictionary, :alpha
  attr_accessor :count

  def initialize(dictionary)
    # Type check to account for a .txt file or an Array
    @dictionary = build_dictionary(dictionary)
    @alpha = ("A".."Z").to_a
  end

  # The workhorse of our program. Size takes in any word and returns the size of
  # it's social network. Implements Breadth First Search with a queue. Words are
  # assessed as they are shifted off and "friends" are pushed to the end of the
  # queue once they are found.
  def size(word)
    @count = 1
    word = type_check(word)
    @words_queue = [word]
    dictionary[word] = true
    until @words_queue.empty?
      count_friends(@words_queue.shift)
    end
    @count
  end

  # Ensures the word only contains letters, has a length, and is all uppercase.
  def type_check(word)
    raise "Your word must only contain letters" unless /^[a-zA-Z]+$/ === word
    word.upcase
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

  # Checks if our current word is within the dictionary and hasn't been seen. If
  # so, add the word to our queue, mark it as seen in the dictionary, and increment
  # our count by 1.
  def check_dictionary(temp)
    if dictionary.has_key?(temp) && dictionary[temp] == false
      @words_queue << temp
      dictionary[temp] = true
      @count += 1
    end
  end

  # Initializes a hash map and constructs the dictionary to ensure constant
  # lookup. Type checks the input to ensure it's a .txt file or an array
  def build_dictionary(dictionary)
    hash = Hash.new
    if dictionary.is_a?(String)
      File.readlines(dictionary).each do |line|
        hash[line.chomp.upcase] = false
      end
    elsif dictionary.is_a?(Array)
      dictionary.each do |line|
        hash[line.chomp.upcase] = false
      end
    else
      raise "Your dictionary must be a .txt file or an array"
    end
    hash
  end

end

word = "LISTY"
size = Social_Network.new('dict/dictionary.txt').size(word)
p "The size of the social network of #{word} is #{size}"
