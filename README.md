## Social Network for LISTY -- David Noah

This program counts the size of the social network of the word LISTY in the dictionary provided.

We define two words as being friends if the edit distance between them is 1. For this problem, we will
be using Levenshtein distance (http://en.wikipedia.org/wiki/Levenshtein_distance) as our edit distance.

The size of a word's social network is equal to 1 (for the word itself), plus the number of words who
are friends with it, plus the number of friends each of its friends has, and so on. A word is in its own
social network, so if our dictionary is simply `[HI]` then the size of the social network for HI is 1.


Example
-------
With dictionary `[HI HERE THERE HER HE SHE HEAR HALLOW]`
The size of the social network for HI is 7. We calculate this as follows:

HI is friends with HE, because they are edit distance 1 apart.

HE is friends with SHE and HER.

HER is friends with HEAR and HERE.

HERE is friends with THERE.

As before, HI is in its own social network.
```
1 + 1 + (1+ 1) + (1 +  1) +  1    = 7
HI  HE  SHE HER  HEAR HERE   THERE
```

Please note that we want to see production quality code! You may write your solution in the programming
language of your choice (we would use Ruby, but you don't have to!). Be sure to include any and all tests
and comments in addition to the logic behind your solution. We want to see code that you feel proud of,
would check in to source control, and would be confident pushing to production for use in a professional
environment. Once your solution is correct, try to make your algorithm as fast as possible. Inclusion of
comments, tests, and a (correct!) speedy solution are all important in our grading of the submissions.

We have included the entire dictionary in dictionary.txt, as well as a few smaller dictionaries for you
to test your code on as you are developing a solution. For your final answer, we want the size of the
social network for LISTY given the entire 178,692 word dictionary in dictionary.txt.

To help you get started, the size of the social network for LISTY in the very_small_test_dictionary.txt is 5

Submission
----------
To submit your solution, please email solutions@apartmentlist.com and include
the following:
* the size of the social network for LISTY using the `dictionary.txt` dictionary
(please include this in the subject of your email)
* a link to the github repository that contains your solution
* your resume

Thank you and good luck!
