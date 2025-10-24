# check_accuracy.py
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

# Load CSV
df = pd.read_csv("lms_log.csv")

# Split into training and test phases
train_df = df[df['index'] < 100]
test_df  = df[df['index'] >= 100]

# Compute MSE
train_mse = ((train_df['d'] - train_df['y'])**2).mean()
test_mse  = ((test_df['d'] - test_df['y'])**2).mean()

print(f"Training MSE: {train_mse:.6f}")
print(f"Test MSE:     {test_mse:.6f}")

# Plot signals for visual inspection
plt.figure(figsize=(10,5))
plt.plot(df['index'], df['d'], label="Desired")
plt.plot(df['index'], df['y'], label="Output")
plt.xlabel("Sample index")
plt.ylabel("Amplitude")
plt.legend()
plt.title("LMS Filter Performance")
plt.grid(True)
plt.show()

