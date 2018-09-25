
import sys
import matplotlib.pyplot as plt
import numpy as np

args = sys.argv

data01_axis1, data01_value1 = np.loadtxt(args[1], unpack=True)
data02_axis2, data02_value2 = np.loadtxt(args[2], unpack=True)

data02_value2 = data02_value2 / 1000000

fig = plt.figure(figsize=(4, 6))
ax = fig.add_subplot(111)
ax.plot(data01_axis1, data01_value1, "-o", markersize=3, color="b", label="True value")
ax.plot(data02_axis2, data02_value2, "o", markersize=0.5, color="r", label="Spruce")

ax.set_xlim(0, 400)
ax.set_ylim(400, 700)
ax.set_xlabel("Time (s)")
ax.set_ylabel("Available bandwidth (Mbps)")

ax.legend(loc="upper right")
plt.show()
