from lib import repeat, shuffle
import pytest

result_4 = [9, 2, 5, 8, 1, 4, 7, 0, 3, 6]


@pytest.mark.parametrize("card_number", result_4)
def test_shuffle_example_4(card_number):
    actions = [
        ["deal", "into", "new", "stack"],
        ["cut", "-2"],
        ["deal", "with", "increment", "7"],
        ["cut", "8"],
        ["cut", "-4"],
        ["deal", "with", "increment", "7"],
        ["cut", "3"],
        ["deal", "with", "increment", "9"],
        ["deal", "with", "increment", "3"],
        ["cut", "-1"]
    ]
    scale, shift = shuffle(actions, 10)
    assert (scale * card_number + shift) % 10 == result_4.index(card_number)

def test_repeat():
    scale, shift = repeat(2, 3, 4, 10)
    assert (scale, shift) == (6, 5)