from collections import Counter
import csv
import os
import sys

csv.field_size_limit(sys.maxsize)

data_path = os.path.join(os.environ["DataPath"], "BayesImpact", "HackathonEscort")
main_path = os.path.join(data_path, "Raw", "escort_all.tsv")

def thorn_row():
	f = open(main_path, "rU")
	r = csv.reader(f, delimiter="\t", lineterminator="\n", quoting=csv.QUOTE_NONE)
	header = r.next()

	for row in r:
		yield row
	f.close()
