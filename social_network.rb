require 'set'

class Social_Network
  attr_reader :length, :word, :dictionary, :alpha

  def initialize(word, dictionary)
    @word = word
    @dictionary = build_dictionary(dictionary)
    @length = word.length
    @alpha = ("A".."Z").to_a
  end

  def size

  end

  def count_check
    count = 0

    length.times do |idx|

    end
  end

  def check_deletions
    count = 0

    length.times do |idx|
      temp = word[0...idx] << word[(idx + 1)...length]
      if dictionary.include?(temp)
        count += 1
      end
    end

    count
  end

  def check_additions
    count = 0

    length.times do |idx|
      alpha.each do |letter|
        if idx == 0
          temp = letter + word
        else
          temp = word[0..idx] + letter + word[idx...length]
        end
        if dictionary.include?(temp)
          count += 1
        end

        if idx == (length - 1)
          temp = word + letter
          if dictionary.include?(temp)
            count += 1
          end
        end
      end
    end

    count
  end

  def check_substitutions
  end

  def build_dictionary(dictionary)
    set = Set.new
    File.readlines(dictionary).each do |line|
      set.add(line.chomp)
    end
    set
  end

end

p Social_Network.new('LISTY', 'dict/very_small_test_dictionary.txt').check_additions
