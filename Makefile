PROJECT_DIR = $(DataPath)/BayesImpact/HackathonEscort
RAW_DIR     = $(PROJECT_DIR)/Raw
WORKING_DIR = $(PROJECT_DIR)/Working

head:
	julia src/head.jl $(RAW_DIR)/escort_all.tsv.gz

head-w:
	julia src/head.jl $(WORKING_DIR)/escort_all.tsv.gz

strip-unicode:
	python src/strip_unicode.py $(RAW_DIR)/escort_all.tsv.gz $(WORKING_DIR)/escort_all.tsv.gz

cities:
	python src/cities.py $(WORKING_DIR)/Cities.csv

sample:
	python src/sample.py $(WORKING_DIR)/Sample.csv

no-text:
	python src/no_text.py $(WORKING_DIR)/NoText.csv

no-text-backpage-only:
	python src/no_text_backpage_only.py $(WORKING_DIR)/NoTextBackpageOnly.csv

phone:
	python src/phone.py $(WORKING_DIR) $(PHONE)
