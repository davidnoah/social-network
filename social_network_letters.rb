require 'set'

class Social_Network
  attr_reader :alpha
  attr_accessor :count, :dictionary

  def initialize(dictionary)
    @letters = Hash.new
    @dictionary = build_dictionary(dictionary)
    @alpha = ("A".."Z").to_a
  end

  def size(word)
    word = normalize(word)
    @seen = Set.new.add(word)
    @words_queue = [word]
    until @words_queue.empty?
      count_friends(@words_queue.shift)
    end
    @seen.size
  end

  def normalize(word)
    raise "Your word must only contain letters" unless /^[a-zA-Z]+$/ === word
    word.upcase
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
    if dictionary.include?(temp) && !@seen.include?(temp)
      @words_queue << temp
      @seen.add(temp)
    end
  end

  def build_dictionary(dictionary)
    set = Set.new
    if dictionary.is_a?(String)
      File.readlines(dictionary).each do |line|
        word = line.chomp.upcase
        set.add(word)
        assess_letters(word)
      end
    elsif dictionary.is_a?(Array)
      dictionary.each do |line|
        word = line.chomp.upcase
        set.add(word)
        assess_letters(word)
      end
    else
      raise "Your dictionary must be a .txt file or an array"
    end
    set
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
