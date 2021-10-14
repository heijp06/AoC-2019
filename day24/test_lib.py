import pytest

from lib import Eris, Recurse


def test_rating_example1():
    eris = Eris(first_twice)
    assert eris.rating() == 2129920

def test_next_gen():
    eris1 = Eris(initial)
    eris1.next()
    eris2 = Eris(next1)
    assert eris1.rating() == eris2.rating()

def test_recurse():
    recurse = Recurse(initial)
    for _ in range(10):
        recurse.next()
    assert recurse.population() == 99

first_twice = [
    ".....",
    ".....",
    ".....",
    "#....",
    ".#...",
    ]

initial = [
    "....#",
    "#..#.",
    "#..##",
    "..#..",
    "#....",
    ]

next1 = [
    "#..#.",
    "####.",
    "###.#",
    "##.##",
    ".##..",
    ]