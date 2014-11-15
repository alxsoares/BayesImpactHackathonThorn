PROJECT_DIR = $(DataPath)/BayesImpact/HackathonEscort
RAW_DIR     = $(PROJECT_DIR)/Raw
WORKING_DIR = $(PROJECT_DIR)/Working

head:
	julia src/head.jl $(RAW_DIR)/escort_all.tsv.gz
