NUMBER_OF_CARDS = 10007
def part1(rows):
    pos = 2019
    for row in rows:
        if row[1] == 'into':
            pos = NUMBER_OF_CARDS - 1 - pos
        elif row[0] == 'cut':
            value = int(row[-1])
            pos = (pos - value) % NUMBER_OF_CARDS
        else:
            value = int(row[-1])
            pos = (pos * value) % NUMBER_OF_CARDS
    return pos

def part2(rows):
    pass