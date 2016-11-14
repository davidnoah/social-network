## Social Network for LISTY -- David Noah

This program counts the size of the social network of the word LISTY in the dictionary provided.

"Friends" are defined as two words with an edit distance of "1". Levenshtein's distance (http://en.wikipedia.org/wiki/Levenshtein_distance) is used as our edit distance. The entire social network is then defined as all the friends of your original word, plus the number of friends each friend has until we have exhausted our social network.

Approach
-------
Dictionary: Set to ensure O(1) lookup.

I knew that the first order on the agenda was to figure out how I would handle the dictionary. I ended up choosing a set to represent the dictionary for a few reasons. One, it would prevent us from having to iterate through the entire dictionary to assess if a word is valid. Two, the key/value pair structure a hash map would have provided is overkill since I only need to check if a word exists. Three, it could provide a good location to implement future pre-processing optimizations. One downside is the space required to hold a dictionary of 178,692 words in memory, but thats an easy tradeoff to make since the dictionary isn't getting any bigger and I would have taken a huge speed hit if I had to iterate through the entire dictionary.

Algorithm: Breadth First Search/Queue

Once the dictionary was built I then implemented a form of BFS to iterate through the entire social network




Optimizations
----------
