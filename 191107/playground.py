#!/usr/bin/env python3

# Given a list of strings return the list
# which contains these strings in lowercase.
# Example: ['AA', 'bB'] -> ['aa', 'bb']
# Hint: you can use s.lower()
def to_lowercase(l):
    pass
    # your code here

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
        if not res or elem != res[-1]:
            res.append(elem)
    return res


# Merge two sorted lists in one sorted list in linear time
#
# Example input: [2, 4, 6], [1, 3, 5]
# Example output: [1, 2, 3, 4, 5, 6]
def linear_merge(lst1, lst2):
    res = []
    len1 = len(lst1)
    len2 = len(lst2)
    pos1 = pos2 = 0
    while pos1 < len1 or pos2 < len2:
        if pos1 < len1 and (pos2 == len2 or lst1[pos1] < lst2[pos2]):
            res.append(lst1[pos1])
            pos1 += 1
        else:
            res.append(lst1[pos2])
            pos2 += 1
    return res


if __name__ == '__main__':
    print(*linear_merge([1, 2], [2, 3]))