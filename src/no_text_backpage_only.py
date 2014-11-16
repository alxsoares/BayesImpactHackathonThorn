import csv
from features import price
import random
import sys
from util import thorn_row

def main():
	out_file = sys.argv[1]
	f = open(out_file, "w")
	w = csv.writer(f)
	w.writerow(["City","Age","Date","Phone","Price"])

	tr = thorn_row()
	samples = []

	for row in tr:
		if len(row)<13:
			continue
		if row[0] != "Backpage.com":
			continue
		w.writerow([row[1], row[4], row[6], row[10], price(row[3], row[5])])

	f.close()

if __name__=="__main__":
	main()
