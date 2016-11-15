require_relative "social_network.rb"

word = "LISTY"
size = Social_Network.new('dict/dictionary.txt').size(word)
p "The size of the social network of #{word} is #{size}"
