#!/usr/bin/env python3
import sys


if __name__ == '__main__':
    filename = sys.argv[1]
    words = []
    f = open(filename, "r")
    for line in f:
        words.extend(line.split())
    f.close()
    d = {}
    for i in words:
        if i in d:
            d[i] = d[i] + 1
        else:
            d2 = {i: 1}
            d.update(d2)
    l2 = []
    j = 0
    while j < 20:
        s = 0
        for i in d:
            if (i not in l2) and (d[i] > s):
                s = d[i]
                k = i
        if k not in l2:
            l2.append(k)
        j = j + 1
    for i in l2:
        print(i)



