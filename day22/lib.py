def part1(actions):
    NUMBER_OF_CARDS = 10007
    scale, shift = shuffle(actions, NUMBER_OF_CARDS)
    return (2019 * scale + shift) % NUMBER_OF_CARDS


def shuffle(actions, number_of_cards):
    scale = 1
    shift = 0
    for row in actions:
        if row[1] == 'into':
            scale *= -1
            shift = -shift + number_of_cards - 1
        elif row[0] == 'cut':
            value = int(row[-1])
            shift -= value
        else:
            value = int(row[-1])
            scale *= value
            shift *= value
        scale %= number_of_cards
        shift %= number_of_cards
    return scale, shift


def part2(actions):
    pass
