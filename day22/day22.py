import csv
from lib import part1, part2


def read_rows(**kwargs):
    with open('data.txt', newline='') as csv_file:
        return list(csv.reader(csv_file, **kwargs))


rows = read_rows(delimiter=' ')

print(f"Part 1: {part1(rows)}")
print(f"Part 2: {part2(rows)}")
