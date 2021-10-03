from lib import part1, part2
import csv

def read_rows():
    with open('data.txt', newline='') as csv_file:
        return list(csv.reader(csv_file, delimiter=' '))

rows = read_rows()

print(f"Part 1: {part1(rows)}")
print(f"Part 2: {part2(rows)}")