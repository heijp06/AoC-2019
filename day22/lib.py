def part1(actions: list[str]) -> int:
    number_of_cards = 10007
    scale, shift = shuffle(actions, number_of_cards)
    return (2019 * scale + shift) % number_of_cards


def part2(actions: list[str]) -> int:
    number_of_cards = 119315717514047
    number_of_shuffles = 101741582076661
    scale, shift = shuffle(actions, number_of_cards)
    scale, shift = repeat(scale, shift, number_of_shuffles, number_of_cards)
    return (2020 - shift) * pow(scale, -1, number_of_cards) % number_of_cards


def shuffle(actions: list[str], number_of_cards: int) -> tuple[int, int]:
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


def repeat(scale: int, shift: int, number_of_shuffles: int, number_of_cards: int) -> tuple[int, int]:
    scale_power_shuffles = pow(scale, number_of_shuffles, number_of_cards)
    inv_scale_minus_one = pow(scale - 1, -1, number_of_cards)
    new_shift = shift * inv_scale_minus_one * \
        (scale_power_shuffles - 1) % number_of_cards
    return scale_power_shuffles, new_shift
