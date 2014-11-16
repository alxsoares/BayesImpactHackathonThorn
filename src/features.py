import re

p = re.compile("\$(\d+)")

def price(title, text):
	m = p.findall(text)
	if m:
		return m[0]
	return ""

white=re.compile('(white|caucasian|caucasians|blonde|brunette|red|blond|blondie)')
black=re.compile('(black|african|ebony|blk|creole|creol|African American|chocolate|chocalate)')
hispanic=re.compile('(hispanic|latina|mexican|puerto rican|cuban|latin)')
asian=re.compile('(asian|asain|oriental)')
indian=re.compile('(indian|lakota|cherokee|navajo|sioux)')

def race(title, text):
    x=(title+text).lower()
    if white.search(x):
        return("white")
    if black.search(x):
        return("black")
    if hispanic.search(x):
        return("hispanic")
    if asian.search(x):
        return("asian")
    if indian.search(x):
        return("indian")
    else:
        return("")
