import gzip
import sys

def main():
    in_file  = sys.argv[1]
    out_file = sys.argv[2]

    f_in  = gzip.open(in_file)
    f_out = gzip.open(out_file, "w")

    for line in f_in:
        f_out.write(line.decode("ascii", "ignore"))

    f_in.close()
    f_out.close()

if __name__=="__main__":
    main()