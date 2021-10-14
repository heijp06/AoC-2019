def part1(rows):
    eris = Eris(rows)
    ratings = set()
    while eris.rating() not in ratings:
        ratings.add(eris.rating())
        eris.next()
    return eris.rating()


def part2(rows):
    recurse = Recurse(rows)
    for _ in range(200):
        recurse.next()
    return recurse.population()


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


class Recurse:
    def __init__(self, layout):
        self._bugs = {
            (0, x, y)
            for x in range(5)
            for y in range(5)
            if (x, y) != (2, 2) and layout[y][x] == '#'
        }

    def population(self):
        return len(self._bugs)

    def next(self):
        min_level = min(l for (l, _, _) in self._bugs)
        max_level = max(l for (l, _, _) in self._bugs)
        self._bugs = {
            (l, x, y)
            for x in range(5)
            for y in range(5)
            for l in range(min_level - 1, max_level + 2)
            if (x, y) != (2, 2) and self.life(l, x, y)
        }

    def life(self, l, x, y):
        neighbors = []
        # up
        if y == 0:
            neighbors.append((l + 1, 2, 1))
        elif (x, y) == (2, 3):
            neighbors.extend([(l - 1, i, 4) for i in range(5)])
        else:
            neighbors.append((l, x, y - 1))
        # left
        if x == 0:
            neighbors.append((l + 1, 1, 2))
        elif (x, y) == (3, 2):
            neighbors.extend([(l - 1, 4, i) for i in range(5)])
        else:
            neighbors.append((l, x - 1, y))
        # right
        if x == 4:
            neighbors.append((l + 1, 3, 2))
        elif (x, y) == (1, 2):
            neighbors.extend([(l - 1, 0, i) for i in range(5)])
        else:
            neighbors.append((l, x + 1, y))
        # down
        if y == 4:
            neighbors.append((l + 1, 2, 3))
        elif (x, y) == (2, 1):
            neighbors.extend([(l - 1, i, 0) for i in range(5)])
        else:
            neighbors.append((l, x, y + 1))
        count = sum(
            b in self._bugs
            for b in neighbors
        )
        return count == 1 or (count == 2 and (l, x, y) not in self._bugs)
