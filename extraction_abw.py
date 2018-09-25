# -*- coding: utf-8 -*-

import sys

args = sys.argv
if len(args) == 2:
    f1 = open(args[1], "r")
    f2 = open("extraction_abw.txt", "w")

    for line in f1:
        if "The AB is" in line:
            cells = line.split()
            f2.write(str(cells[0]) + " " + str(cells[4]) + "\n")

    f1.close()
    f2.close()

else:
    print("No argv[1] ...")
