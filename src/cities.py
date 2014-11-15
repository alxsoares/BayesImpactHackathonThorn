from collections import Counter
import csv
from util import thorn_row
import sys

def main():
	out_file = sys.argv[1]

	cities = Counter()
	tr = thorn_row()

	for row in tr:
		if len(row)>1:
			cities[row[1]] += 1

	rows = [[c, cities[c]] for c in cities]
	f = open(out_file, "w")
	w = csv.writer(f)
	w.writerow(["City","Count"])
	w.writerows(rows)
	f.close()

if __name__=="__main__":
	main()