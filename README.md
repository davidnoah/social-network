## Social Network for LISTY -- David Noah

This program counts the size of the social network of the word LISTY in the dictionary provided.

"Friends" are defined as two words with an edit distance of "1". Levenshtein's distance (http://en.wikipedia.org/wiki/Levenshtein_distance) is used as our edit distance. The entire social network is then defined as all the friends of your original word, plus the number of friends each friend has until we have exhausted our social network.

Running the File
-------
1. Clone this repository (git clone https://github.com/davidnoah/social-network.git)
2. Navigate to the location that contains this repository within your terminal.
3. Type 'ruby social_network.rb' into your terminal.

Approach
-------
Dictionary: Hash map to ensure O(1) lookup.

I knew that the first order on the agenda was to figure out how I would handle the dictionary. I ended up choosing a hash map to represent the dictionary for a few reasons. One, it would prevent us from having to iterate through the entire dictionary to check if a word is valid. Two, it could provide a good location to implement future pre-processing optimizations. One downside is the space required to hold a dictionary of 178,692 words in memory, but thats an easy tradeoff to make since the dictionary isn't getting larger and I would have taken a massive speed hit if I had to iterate through the entire dictionary for each "friend".

Algorithm: Breadth First Search/Queue

Conceptually, the social network can be represented by the abstract data type, Tree. Our root node is the initial word, in this case, "LISTY". It's children are all of it's friends. In order to count all of these friends, we must traverse this tree. I chose a Breadth First Search traversal because I knew that we would be essentially constructing the tree as we move through it. The data structure, Queue maintains order and allows us to remember which node we should assess next. (First In First Out)

  Assessing a word:
  
    - Shift the oldest word off of the queue.
    - Find and count all the words with an edit distance of 1 (insertions, deletions, additions)
    - Add each friend to the end of the queue
    - Repeat until queue is empty.

Complexity
-------
  - Time: 0(n), where n is the number of words in the dictionary.
  - Space: 0(n), where n is the number of words in the dictionary.

  We can make the assumption that the average length of an English word is 5 characters. Our best case scenario states that there are absolutely no friends for our tested word in the dictionary and our network has a size of 1. With our above assumption, best case, our algorithm is a constant operation, O(1). The best case scenario is arbitrary and we are more concerned with our worst case scenario. In a worst case scenario, our social network will be equivalent to the size of our dictionary.

  Average length: 5

  Checking deletions: length of 5 = 5 operations

  Checking additions: 6 spaces * 26 letters = 156 operations

  Checking substitutions: length of 5 * 26 letters = 140 operations

  O(301n) which can be reduced to O(n)

Optimizations
-------
