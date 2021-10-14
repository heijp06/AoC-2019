def part1(rows):
    eris = Eris(rows)
    ratings = set()
    while eris.rating() not in ratings:
        ratings.add(eris.rating())
        eris.next()
    return eris.rating()


def part2(rows):
    pass


class Eris:
    def __init__(self, layout):
        self._bugs = {
            (x, y)
            for x in range(5)
            for y in range(5)
            if layout[y][x] == '#'
        }

    def rating(self):
        return sum(2 ** (x + 5 * y) for (x, y) in self._bugs)

    def next(self):
        self._bugs = {
            (x, y)
            for x in range(5)
            for y in range(5)
            if self.life(x, y)
        }

    def life(self, x, y):
        count = sum(
            (x + dx, y + dy) in self._bugs
            for (dx, dy) in [(0, 1), (-1, 0), (1, 0), (0, -1)]
        )
        return count == 1 or (count == 2 and (x, y) not in self._bugs)
