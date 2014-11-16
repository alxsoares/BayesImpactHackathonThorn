import csv
import os
import random
import re
import sys
from util import thorn_row

data_path = os.path.join(os.environ["DataPath"], "BayesImpact", "HackathonEscort")
main_path = os.path.join(data_path, "Working", "Labels.csv")

def main():
	tr = thorn_row()
	samples = []

	p = re.compile("\$\d+")
	i = 0

	f = open(main_path, "a")
	w = csv.writer(f)

	for row in tr:
		i += 1
		if random.random()<0.001:
			if len(row)>5:
				val = row[5].decode("ascii", "ignore")
				print(val)

				for m in p.finditer(val):
					print(m.start(), m.group())
					loc = m.start()
					print(val[loc-10:loc+10])
					try:
						result = input("1 if price, 2 if other")
						w.writerow([i, m.group(), val[loc-10:loc+10], m.start(),result])
					except SyntaxError:
						pass

if __name__=="__main__":
	main()