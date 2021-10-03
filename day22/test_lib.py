from lib import shuffle
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
    assert shuffle(actions, card_number, 10) == result_4.index(card_number)
