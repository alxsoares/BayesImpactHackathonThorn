import csv
from util import thorn_row
import random
import sys

def main():
	out_file = sys.argv[1]
	f = open(out_file, "w")
	w = csv.writer(f)
	w.writerow(["Site","City","Age","Date","Phone"])

	tr = thorn_row()
	samples = []

	for row in tr:
		if len(row)<13:
			continue
		w.writerow([row[0], row[1], row[4], row[6], row[10]])

	f.close()

if __name__=="__main__":
	main()
