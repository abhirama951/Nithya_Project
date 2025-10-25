import numpy as np

# ----------------------------
# Parameters
# ----------------------------
num_samples = 100
amplitude = 1.0   # max value of signal in float
qformat_bits = 12 # fractional bits for Q4.12
filename_x = "x_input.txt"
filename_d = "d_input.txt"

# ----------------------------
# Generate example input signal
# ----------------------------
# Example: sine wave
t = np.arange(num_samples)
x_float = amplitude * np.sin(2*np.pi*0.05*t)  # 0.05 cycles/sample

# Example desired output: x delayed by 1 sample (simple FIR target)
d_float = np.roll(x_float, 1)
d_float[0] = 0  # first value

# ----------------------------
# Convert to Q4.12 fixed-point
# ----------------------------
scale = 2**qformat_bits

x_fixed = np.round(x_float * scale).astype(int)
d_fixed = np.round(d_float * scale).astype(int)

# ----------------------------
# Save to files in binary format (Verilog readmemb)
# ----------------------------
with open(filename_x, "w") as fx:
    for val in x_fixed:
        if val < 0:
            val = (1<<16) + val  # convert to 16-bit 2's complement
        fx.write(f"{val:016b}\n")

with open(filename_d, "w") as fd:
    for val in d_fixed:
        if val < 0:
            val = (1<<16) + val
        fd.write(f"{val:016b}\n")

print(f"Generated {filename_x} and {filename_d} with {num_samples} samples.")

