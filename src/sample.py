import csv
from util import thorn_row
import random
import sys

def main():
	out_file = sys.argv[1]

	tr = thorn_row()
	samples = []

	for row in tr:
		if random.random()<0.001:
			samples.append(row)

	f = open(out_file, "w")
	w = csv.writer(f)
	w.writerows(samples)
	f.close()

if __name__=="__main__":
	main()