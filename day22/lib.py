def part1(actions):
    NUMBER_OF_CARDS = 10007
    scale, shift = shuffle(actions, NUMBER_OF_CARDS)
    return (2019 * scale + shift) % NUMBER_OF_CARDS


def part2(actions):
    NUMBER_OF_CARDS = 119315717514047
    NUMBER_OF_SHUFFLES = 101741582076661
    scale, shift = shuffle(actions, NUMBER_OF_CARDS)
    scale, shift = repeat(scale, shift, NUMBER_OF_SHUFFLES, NUMBER_OF_CARDS)
    return ((2020 - shift) * pow(scale, -1, NUMBER_OF_CARDS)) % NUMBER_OF_CARDS


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


def repeat(scale, shift, number_of_shuffles, number_of_cards):
    new_scale = pow(scale, number_of_shuffles, number_of_cards)
    inv_scale_minus_one = pow(scale - 1, -1, number_of_cards)
    new_shift = (shift * inv_scale_minus_one * (new_scale - 1)) % number_of_cards
    return new_scale, new_shift