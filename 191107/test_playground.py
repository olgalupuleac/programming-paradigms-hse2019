#!/usr/bin/env python3
#import playground
from playground import verbing
from playground import remove_adjacent

def test_verbing_small_len():
    assert verbing('a') == 'a'


def test_verbing_ends_with_ing():
    assert verbing('startling') == 'startlingly'


def test_verbing_add_ing():
    assert verbing('fill') == 'filling'


def test_remove_adjacent():
    assert remove_adjacent([1, 2, 2, 3]) == [1, 2, 3]


def test_remove_adjacent_all_equal():
    assert remove_adjacent([1, 1, 1, 1]) == [1]


def test_remove_adjacent_all_unique():
    assert remove_adjacent([1, 2, 3]) == [1, 2, 3]


def test_remove_adjacent_empty_list():
    assert remove_adjacent([]) == []


def test_remove_adjacent_different_types():
    assert remove_adjacent([1, [], [], [[]], []]) == [1, [], [[]], []]

