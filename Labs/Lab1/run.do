vlib work
vmap work work
vcom +cover=bcesf *.vhd
vlog +cover=bcesf *.v
vsim -coverage -fsmdebug -voptargs=+acc -onfinish stop work.tb_top
do wave.do
run -all
coverage report -html -output cov_report.html