# run.do
# Top-level simulation script for the Lab2 FSM (fsm_mealy_2p + fsm_mealy_tb).
# Compiles the DUT and testbench, loads the design, opens the waveform
# layout from wave.do, and runs the simulation.
#
# Usage: launch ModelSim/Questa with this folder as the working directory
# (fsm_mealy_tb.vhd opens fsm_test_vectors.txt / fsm_test_results.txt with
# relative paths), then at the Transcript prompt:  do run.do
# Or headless: vsim -c -do run.do

if {![file isdirectory work]} {
    vlib work
    vmap work work
}

vcom fsm_mealy_2p.vhd
vcom fsm_mealy_tb.vhd

vsim tb

do wave.do

# clk_gen free-runs forever with no stop condition, so `run -all` would
# never halt on its own; 500 ns comfortably covers all 16 vectors + margin.
run 500 ns

wave zoom full
