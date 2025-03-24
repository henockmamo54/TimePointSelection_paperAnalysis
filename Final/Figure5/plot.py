from matplotlib import pyplot as plt
import matplotlib.patches as patches
import pandas as pd

data=pd.read_csv("temp.csv")


fig, ax = plt.subplots(1)

# Create a rectangle patch
rect=patches.Rectangle((4 - 0.4, 0.03887-0.005), 4 +0.4, 0.514-0.03887 +0.01, facecolor="g", alpha=0.2)


ax.plot(data['Labeling Duration'],data['Lower Limit (theo.)'],c='k')
ax.plot(data['Labeling Duration'],data['Upper Limit (theo.)'],c='r')

ax.scatter(data['Labeling Duration'],data['Lower Limit (exp.)'],c='k',label="Lower Limit (exp.)")
ax.scatter(data['Labeling Duration'],data['Upper Limit (exp.)'],c='r',label='Upper Limit (exp.)')

ax.add_patch(rect)

ax.text(20,0.4778,"Upper Limit (theo.)", ha='center', va='bottom', fontsize=10) 
ax.text(20,0.03887,"Lower Limit (theo.)", ha='center', va='bottom', fontsize=10) 

plt.gca().spines['top'].set_visible(False)
plt.gca().spines['right'].set_visible(False)
plt.ylim([0,0.65])

plt.xlabel("Labeling Duration (Days)")
plt.legend(frameon=False, loc='upper right')

plt.savefig("Figure5.jpeg",dpi=900)

plt.show()