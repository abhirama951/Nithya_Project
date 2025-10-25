import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

# ----------------------------
# Parameters
# ----------------------------
csv_file = "lms_output.csv"  # produced by Verilog TB
qformat_bits = 12             # Q4.12 fixed-point
scale = 2**qformat_bits

# ----------------------------
# Load CSV
# ----------------------------
df = pd.read_csv(csv_file)

# Assuming CSV columns: time,x_in,y_out,d_in,err,w0,w1,w2,w3
# Convert Q4.12 to float
df['x_in_f']   = df['x_in'] / scale
df['y_out_f']  = df['y_out'] / scale
df['d_in_f']   = df['d_in'] / scale
df['err_f']    = df['err'] / scale
df['w0_f']     = df['w0'] / scale
df['w1_f']     = df['w1'] / scale
df['w2_f']     = df['w2'] / scale
df['w3_f']     = df['w3'] / scale

# ----------------------------
# Compute accuracy metrics
# ----------------------------
mse = np.mean((df['y_out_f'] - df['d_in_f'])**2)
mae = np.mean(np.abs(df['y_out_f'] - df['d_in_f']))

print(f"Mean Squared Error: {mse:.6f}")
print(f"Mean Absolute Error: {mae:.6f}")

# ----------------------------
# Plot results
# ----------------------------
plt.figure(figsize=(10,5))
plt.plot(df['x_in_f'], label='Input x')
plt.plot(df['d_in_f'], label='Desired d')
plt.plot(df['y_out_f'], label='Filter output y')
plt.xlabel('Sample')
plt.ylabel('Amplitude')
plt.title('LMS Filter Output vs Desired')
plt.legend()
plt.grid(True)
plt.show()

# Optional: plot weights evolution
plt.figure(figsize=(10,5))
plt.plot(df['w0_f'], label='w0')
plt.plot(df['w1_f'], label='w1')
plt.plot(df['w2_f'], label='w2')
plt.plot(df['w3_f'], label='w3')
plt.xlabel('Sample')
plt.ylabel('Weight value')
plt.title('LMS Weights Evolution')
plt.legend()
plt.grid(True)
plt.show()

