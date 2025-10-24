Files:

LMS.v : LMS implementation
wb_lms.v : Wrapper to make LMS wishbone compatible
wb_lms_tb.v : Testbench
gen.py : generate a text file of signals to test design
check.py : script to check accuracy


Steps : 

python3 gen.py
iverilog -g2012 -o sim.out LMS.v wb_lms.v wb_lms_tb.v
vvp sim.out
python3 check.py

