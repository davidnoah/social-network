require 'set'

class Social_Network
  attr_reader :alpha
  attr_accessor :count, :dictionary

  def initialize(dictionary)
    @letters = Hash.new
    @dictionary = build_dictionary(dictionary)
    @alpha = ("A".."Z").to_a
    @count = 1
  end

  def size(word)
    starttime = Time.now
    @words_queue = [word]
    dictionary[word] = true
    until @words_queue.empty?
      count_friends(@words_queue.shift)
    end
    endtime = Time.now
    p "Runtime: #{endtime - starttime} seconds"
    @count
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
    @letters[index].each do |letter|
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
    @letters[index].each do |letter|
      temp = current_word[0...index] + letter + current_word[(index + 1)...length]
      check_dictionary(temp)
    end
  end

  def check_dictionary(temp)
    if dictionary.has_key?(temp) && dictionary[temp] == false
      @words_queue << temp
      dictionary[temp] = true
      @count += 1
    end
  end

  def build_dictionary(dictionary)
    hash = {}
    File.readlines(dictionary).each do |line|
      word = line.chomp
      assess_letters(word)
      hash[word] = false
    end
    hash
  end

  def assess_letters(word)
    word.length.times do |index|
      if @letters[index]
        @letters[index].add(word[index])
      else
        @letters[index] = Set.new.add(word[index])
      end
    end
  end

end

word = "LISTY"
size = Social_Network.new('dict/half_dictionary.txt').size(word)
p "The size of the social network of #{word} is #{size}"

# Full Dict
# "Runtime: 20.580995 seconds"
# "The size of the social network of LISTY is 51710"
# [Finished in 21.616s]

# Half Dictionary
# "Runtime: 7.900541 seconds"
# "The size of the social network of LISTY is 22741"
# [Finished in 8.454s]

# Quarter Dictionary
# "Runtime: 3.49913 seconds"
# "The size of the social network of LISTY is 11008"
# [Finished in 3.847s]
