#!/usr/bin/env python3

# Given a string, if its length is at least 3,
# add 'ing' to its end.
# Unless it already ends in 'ing', in which case
# add 'ly' instead.
# If the string length is less than 3, leave it unchanged.
# Return the resulting string.
#
# Example input: 'read'
# Example output: 'reading'
def verbing(s):
    if len(s) >= 3:
        if s[-3:] != 'ing':
            return s + 'ing'
        return s + 'ly'
    return s


# Remove equal adjacent elements
#
# Example input: [1, 2, 2, 3]
# Example output: [1, 2, 3]
def remove_adjacent(lst):
    res = []
    for elem in lst:
        if elem != res[-1]:
            res.append(elem)
    return res

print('hello')

#if __name__ == '__main__':
#    remove_adjacent([1, 1, 2, 1])