import sys
import os
import random
import numpy as np

sample = sys.argv[1]
output_dir = sys.argv[2]

# get sample name with full path or ending
sample = os.path.basename(sample).replace(".txt","")

# reads as list
reads = []
with open(output_dir+"/read_names/" + sample + ".txt", "r") as input_file:
    for line in input_file:
        reads.append(line.strip("\n"))

# shuffle
random.shuffle(reads)

# intervals for subsampling
intervals = list(map(int, np.linspace(0, len(reads), num=11)[1:]))

# write to files
for i in range(len(intervals)):
    with(open(output_dir+"/subsample/" + sample + "_" + str(i) + ".txt", "w")) as output_file:
        for r in reads[0:intervals[i]]:
            output_file.write(r + "\n")

