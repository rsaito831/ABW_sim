
import sys
import numpy as np

args = sys.argv
if len(args) == 3:
    f = open("ave_abw.txt", "a")
    data01_axis1, data01_value1 = np.loadtxt(args[1], unpack=True)
    data01_value1 = data01_value1 / 1000000
    ave_abw = np.average(data01_value1)

    f.write(str(args[2]) + " " + str(ave_abw) + "\n")

    f.close()

else:
    print("No argv[1] ...")
