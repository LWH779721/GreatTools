#!/usr/bin/env python3

import sys

def checkout_lines_from_file(file_name, file_out):
    with open(file_name, "r", encoding="utf-8") as fin:
        with open(file_out, "w", encoding="utf-8") as fout:
            for line in fin:
                index = line.find("WARNING")
                if index >= 0:
                    fout.write(line)
                else:
                    index = line.find("KEY")    
                    if index >= 0:
                        fout.write(line)
    

def check_out_line(file_in, file_out):
    with open(file_in, "r") as fin:
        with open(file_out, "w") as fout:
            last = 0
            for line in fin:
                #index = line.find("ts:")
                index = line.find("T01")
                index1 = line.find("frame")
                if index >= 0:
                    fout.write(line[index:-4] + "\n")
                
                if index1 >= 0:
                    #fout.write(line[index1:-4] + "\n")
                    tmp = int(line[index1 + 10:-4])
                    diff = tmp - int(last)
                    last = tmp
                    fout.write(str(diff) + "\n")

   
if __name__ == "__main__":
    checkout_lines_from_file(sys.argv[1], sys.argv[2])