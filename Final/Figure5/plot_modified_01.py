from matplotlib import pyplot as plt
import matplotlib.patches as patches
import pandas as pd

data=pd.read_csv("temp_0_1.csv")

temp_data=data[data['In Range']==True]


fig, ax = plt.subplots(figsize=(8,5))

low=max(temp_data['Upper Limit (theo.)'])
high=max(temp_data['Lower Limit (theo.)'])

# Create a rectangle patch
rect=patches.Rectangle(( min(temp_data['Labeling Duration']) - 0.4, low),
                        max(temp_data['Labeling Duration']) -min(temp_data['Labeling Duration']) +0.7, 
                        high-low , facecolor="g", alpha=0.2)


ax.plot(data['Labeling Duration'],data['Lower Limit (theo.)'],c='m',ls=':')
ax.plot(data['Labeling Duration'],data['Upper Limit (theo.)'],c='r',ls=':') 

# ax.scatter(data['Labeling Duration'],data['Lower Limit (exp.)'],c='k',label="Lower Limit (exp.)")
# ax.scatter(data['Labeling Duration'],data['Upper Limit (exp.)'],c='r',label='Upper Limit (exp.)')

ax.scatter(data['Labeling Duration'],data['Lower Limit (exp.)'],c='k',alpha=0.7 )

ax.add_patch(rect)

# ax.text(20,0.514,"Upper Limit (theo.)", ha='center', va='bottom', fontsize=10) 
# ax.text(20,0.4778,"Lower Limit (theo.)", ha='center', va='bottom', fontsize=10) 
ax.text(17, low, "Lower Limit (theo.) = " +r"$0.65 * I_0(0) + 0.35 * I_0^{asmyp}$", ha='center', va='bottom', fontsize=10, color='r')
ax.text(17, high, r"Upper Limit (theo.) = $I_0(0) - 0.031$", ha='center', va='bottom', fontsize=10, color='m')

plt.gca().spines['top'].set_visible(False)
plt.gca().spines['right'].set_visible(False)
plt.ylim([0.34,0.55])

plt.xlabel("Labeling Duration (Days)")
ax.set_ylabel(r"$I_0(t) = I_0^{asmyp} + (I_0(0) - I_0^{asmyp})e^{-kt}$")
# plt.legend(frameon=False, loc='upper right')

plt.savefig("Figure5_01.jpeg",dpi=900)

plt.show()