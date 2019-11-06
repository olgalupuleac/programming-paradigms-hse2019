from verbing import verbing


def test_small_len():
    assert verbing('a') == 'a'


def test_ends_with_ing():
    assert verbing('startling') == 'startlingly'


def test_add_ing():
    assert verbing('fill') == 'filling'


def test_wrong():
    assert verbing('go') == 'going'