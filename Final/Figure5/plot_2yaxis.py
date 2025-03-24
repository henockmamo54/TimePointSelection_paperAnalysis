from matplotlib import pyplot as plt
import matplotlib.patches as patches
import pandas as pd

# Load data
data = pd.read_csv("temp.csv")
 
fig, ax1 = plt.subplots(figsize=(9,6))

# Create a second y-axis
ax2 = ax1.twinx()

# Create a rectangle patch
rect = patches.Rectangle((4 - 0.4, 0.03887 - 0.005), 4 + 0.4, 0.514 - 0.03887 + 0.01, facecolor="g", alpha=0.2)

# Primary y-axis plots
ax1.plot(data['Labeling Duration'], data['Upper Limit (theo.)'], c='r') #, label="Upper Limit (theo.)"
ax1.scatter(data['Labeling Duration'], data['Upper Limit (exp.)'], c='r', label="Upper Limit (exp.)")

# Secondary y-axis plots
ax2.plot(data['Labeling Duration'], data['Lower Limit (theo.)'], c='k', linestyle='dashed') #, label="Lower Limit (theo.)"
ax2.scatter(data['Labeling Duration'], data['Lower Limit (exp.)'], c='k', label="Lower Limit (exp.)")

ax1.add_patch(rect)

# Labels and text annotations
ax1.text(17, 0.4778, "Upper Limit (theo.) = " +r"$0.65 * I_0(0) + 0.35 * I_0^{asmyp}$", ha='center', va='bottom', fontsize=8, color='r')
ax2.text(20, 0.03887, "Lower Limit (theo.) = 0.031", ha='center', va='bottom', fontsize=8, color='k')

# Hide top and right spines
ax1.spines['top'].set_visible(False)
ax2.spines['top'].set_visible(False)

# Set limits and labels
ax1.set_ylim([0, 0.65])
ax2.set_ylim([0, 0.4])  # Adjust according to the range of 'Lower Limit (theo.)'

ax1.set_xlabel("Labeling Duration (Days)")
ax1.set_ylabel(r"$I_0^{asmyp} + (I_0(0) - I_0^{asmyp})e^{-kt}$" + "\nUpper Limit (exp.)"  )
ax2.set_ylabel( r"$(I_0(0) - I_0^{asmyp}) (1-e^{-kt})$" + "\nLower Limit (exp.)" )

# Combine legends from both axes
ax1.legend(loc='upper right', frameon=False)
ax2.legend(loc='lower right', frameon=False)

plt.tight_layout()
# Save and show plot
plt.savefig("Figure5.jpeg", dpi=900)
plt.show()
