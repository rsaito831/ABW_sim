
import sys
import matplotlib.pyplot as plt
import numpy as np

args = sys.argv

data01_axis1, data01_value1 = np.loadtxt(args[1], unpack=True)
data02_axis2, data02_value2 = np.loadtxt(args[2], unpack=True)


fig = plt.figure(figsize=(5, 5))
ax = fig.add_subplot(111)
ax.plot(data01_axis1, data01_value1, "--", markersize=7, color="k", label="True value")
ax.plot(data02_axis2, data02_value2, "-o", markersize=5, color="r", label="Spruce")

ax.set_xlim(0, 1000)
ax.set_ylim(0, 1000)
ax.set_xlabel("Actual Available bandwidth (Mbps)")
ax.set_ylabel("Measured Available bandwidth (Mbps)")

ax.legend(loc="upper right")
plt.show()
