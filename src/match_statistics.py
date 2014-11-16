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

	pattern_strings = [r"\$\d+", r"\d+\$", r"\$", r"price", r"dollar", r"cost", r"(hour)|(hr)", r"minute", r"min", r"underage", r"young", r"child"]
	patterns = [re.compile(x) for x in pattern_strings]
	pattern_matches = [0 for p in patterns]
	i = 0

	for row in tr:
		i += 1
		if len(row)<6:
			continue
		for (ip, p) in enumerate(patterns):
			if len(p.findall(row[5]))>0:
				pattern_matches[ip] += 1
		if i%10000==0:
			print("\n".join("%s\t%0.3f%%" % (pattern_strings[ix] , 100.0*pattern_matches[ix]/i) for ix in range(len(pattern_matches))))

if __name__=="__main__":
	main()