def part1(actions):
    return shuffle(actions, 2019, 10007)


def shuffle(actions, pos, number_of_cards):
    for row in actions:
        if row[1] == 'into':
            pos = number_of_cards - 1 - pos
        elif row[0] == 'cut':
            value = int(row[-1])
            pos = (pos - value) % number_of_cards
        else:
            value = int(row[-1])
            pos = (pos * value) % number_of_cards
    return pos


def part2(actions):
    pass
