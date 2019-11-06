def remove_adjacent(lst):
    res=[lst[0]]
    for i in range(1,len(lst)):
        if lst[i]!=lst[i-1]:
            res.append(lst[i])
    return res
