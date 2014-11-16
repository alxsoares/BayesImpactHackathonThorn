import csv
import os
import random
import sys
from util import thorn_row

def main():
	out_path = sys.argv[1]
	phone_number = sys.argv[2]
	f = open(os.path.join(out_path, "Phone"+phone_number+".csv"), "w")
	w = csv.writer(f)
#	w.writerow(["Site","City","Age","Date","Phone"])

	tr = thorn_row()
	samples = []

	for row in tr:
		if len(row)<13:
			continue
		phone = row[10]
		if phone==phone_number:
			w.writerow(row)

	f.close()

if __name__=="__main__":
	main()
