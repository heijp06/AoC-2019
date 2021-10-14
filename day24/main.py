import csv
from lib import part1, part2


def read_rows(**kwargs):
    with open('data.txt') as csv_file:
        return csv_file.read().splitlines()


rows = read_rows()
solution1 = part1(rows)
print(f"Part 1: {solution1}")

rows = read_rows()
solution2 = part2(rows)
print(f"Part 2: {solution2}")
