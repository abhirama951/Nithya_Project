import numpy as np

N = 100
amplitude = 0.5
freq = 0.08
noise_std = 0.4

SCALE = 2**12

n = np.arange(N)
x = amplitude * np.sin(2*np.pi*freq*n) + np.random.normal(0, noise_std, N)
d = amplitude * np.sin(2*np.pi*freq*n)

def to_fixed(val):
    scaled = int(round(val * SCALE))
    if scaled > 32767:
        scaled = 32767
    elif scaled < -32768:
        scaled = -32768
    return np.int16(scaled)

x_fixed = np.array([to_fixed(v) for v in x], dtype=np.int16)
d_fixed = np.array([to_fixed(v) for v in d], dtype=np.int16)

with open("LMS_inputs.txt", "w") as f:
    for val in x_fixed:
        f.write(f"{val.astype(np.uint16):016b}\n")

with open("LMS_expected.txt", "w") as f:
    for val in d_fixed:
        f.write(f"{val.astype(np.uint16):016b}\n")

print("Generated files with", N, "samples")

