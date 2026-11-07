# wave.do
# Waveform window setup for the fsm_mealy_2p testbench (top-level entity: tb).
# Not meant to be run standalone — it's sourced from run.do via `do wave.do`
# after `vsim tb` has already loaded the design.

onerror {resume}
quietly WaveActivateNextPane {} 0

add wave -noupdate -divider "Testbench I/O"
add wave -noupdate -format Logic /tb/clk_in
add wave -noupdate -format Logic /tb/reset_in
add wave -noupdate -format Logic /tb/x_in
add wave -noupdate -format Logic /tb/y_out

add wave -noupdate -divider "DUT Internal State"
add wave -noupdate -format Literal /tb/DUT/current_state
add wave -noupdate -format Literal /tb/DUT/next_state

TreeUpdate [SetDefaultTree]
configure wave -namecolwidth 180
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 10
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns

update
wave zoom full
