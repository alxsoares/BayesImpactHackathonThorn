import re

p = re.compile("\$(\d+)")

def price(title, text):
	m = p.findall(title + " " + text)
	if m:
		return m[0]
	return ""
