"""Wordcount exercise
Google's Python class

The main() below is already defined and complete. It calls print_words()
and print_top() functions which you write.

1. For the --count flag, implement a print_words(filename) function that counts
how often each word appears in the text and prints:
word1 count1
word2 count2
...

Print the above list in order sorted by word (python will sort punctuation to
come before letters -- that's fine). Store all the words as lowercase,
so 'The' and 'the' count as the same word.

2. For the --topcount flag, implement a print_top(filename) which is similar
to print_words() but which prints just the top 20 most common words sorted
so the most common word is first, then the next most common, and so on.

Use str.split() (no arguments) to split on all whitespace.

Workflow: don't build the whole program at once. Get it to an intermediate
milestone and print your data structure and sys.exit(0).
When that's working, try for the next milestone.

Optional: define a helper function to avoid code duplication inside
print_words() and print_top().

"""

import sys


def read_words(filename):
    words = []
    f =  open(filename, "r")
    for line in f:
        words.extend(line.split())
    f.close()
    return words


def count_words(filename):
    d = {}
    for i in read_words(filename):
        if i in d:
            d[i] = d[i] + 1
        else:
            d2 = {i: 1}
            d.update(d2)
    return (d)


def print_words(filename):
    dct = count_words(filename)
    l1 = sorted(dct.keys())
    for x in l1:
        print(x, ' ', dct[x])


def print_top(filename):
    dct = count_words(filename)
    l2 = []
    j = 0
    while j < 20:
        s = 0
        for i in dct:
            if (i not in l2) and (dct[i] > s):
                s = dct[i]
                k = i
        if k not in l2:
            l2.append(k)
        j = j + 1
    for i in l2:
        print(i)


# Define print_words(filename) and print_top(filename) functions.
# You could write a helper utility function that reads a file
# and builds and returns a word/count dict for it.
# Then print_words() and print_top() can just call the utility function.

###

# This basic command line argument parsing code is provided and
# calls the print_words() and print_top() functions which you must define.
def main():
    if len(sys.argv) != 3:
        print('usage: ./wordcount.py {--count | --topcount} file')
        sys.exit(1)

    option = sys.argv[1]
    filename = sys.argv[2]
    if option == '--count':
        print_words(filename)
    elif option == '--topcount':
        print_top(filename)
    else:
        print('unknown option: ' + option)
        sys.exit(1)


if __name__ == '__main__':
    main()
