transcript on
if ![file isdirectory verilog_libs] {
	file mkdir verilog_libs
}

vlib verilog_libs/altera_ver
vmap altera_ver ./verilog_libs/altera_ver
vlog -vlog01compat -work altera_ver {c:/quartus/quartus/eda/sim_lib/altera_primitives.v}

vlib verilog_libs/lpm_ver
vmap lpm_ver ./verilog_libs/lpm_ver
vlog -vlog01compat -work lpm_ver {c:/quartus/quartus/eda/sim_lib/220model.v}

vlib verilog_libs/sgate_ver
vmap sgate_ver ./verilog_libs/sgate_ver
vlog -vlog01compat -work sgate_ver {c:/quartus/quartus/eda/sim_lib/sgate.v}

vlib verilog_libs/altera_mf_ver
vmap altera_mf_ver ./verilog_libs/altera_mf_ver
vlog -vlog01compat -work altera_mf_ver {c:/quartus/quartus/eda/sim_lib/altera_mf.v}

vlib verilog_libs/altera_lnsim_ver
vmap altera_lnsim_ver ./verilog_libs/altera_lnsim_ver
vlog -sv -work altera_lnsim_ver {c:/quartus/quartus/eda/sim_lib/altera_lnsim.sv}

vlib verilog_libs/cycloneive_ver
vmap cycloneive_ver ./verilog_libs/cycloneive_ver
vlog -vlog01compat -work cycloneive_ver {c:/quartus/quartus/eda/sim_lib/cycloneive_atoms.v}

if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/FPGA_source/FPGA_MP801/MP801_example_project/mdyOsc_v1.1/Oscill_main_top {C:/FPGA_source/FPGA_MP801/MP801_example_project/mdyOsc_v1.1/Oscill_main_top/Oscill_key.v}
vlog -vlog01compat -work work +incdir+C:/FPGA_source/FPGA_MP801/MP801_example_project/mdyOsc_v1.1/Oscill_main_top {C:/FPGA_source/FPGA_MP801/MP801_example_project/mdyOsc_v1.1/Oscill_main_top/Oscill_ram.v}
vlog -vlog01compat -work work +incdir+C:/FPGA_source/FPGA_MP801/MP801_example_project/mdyOsc_v1.1/Oscill_main_top {C:/FPGA_source/FPGA_MP801/MP801_example_project/mdyOsc_v1.1/Oscill_main_top/Oscill_PLL_32M.v}
vlog -vlog01compat -work work +incdir+C:/FPGA_source/FPGA_MP801/MP801_example_project/mdyOsc_v1.1/Oscill_main_top {C:/FPGA_source/FPGA_MP801/MP801_example_project/mdyOsc_v1.1/Oscill_main_top/Oscill_fifo_sel.v}
vlog -vlog01compat -work work +incdir+C:/FPGA_source/FPGA_MP801/MP801_example_project/mdyOsc_v1.1/Oscill_main_top {C:/FPGA_source/FPGA_MP801/MP801_example_project/mdyOsc_v1.1/Oscill_main_top/Oscill_fifo.v}
vlog -vlog01compat -work work +incdir+C:/FPGA_source/FPGA_MP801/MP801_example_project/mdyOsc_v1.1/Oscill_main_top {C:/FPGA_source/FPGA_MP801/MP801_example_project/mdyOsc_v1.1/Oscill_main_top/Oscill_vga_driver.v}
vlog -vlog01compat -work work +incdir+C:/FPGA_source/FPGA_MP801/MP801_example_project/mdyOsc_v1.1/Oscill_main_top {C:/FPGA_source/FPGA_MP801/MP801_example_project/mdyOsc_v1.1/Oscill_main_top/Oscill_show.v}
vlog -vlog01compat -work work +incdir+C:/FPGA_source/FPGA_MP801/MP801_example_project/mdyOsc_v1.1/Oscill_main_top {C:/FPGA_source/FPGA_MP801/MP801_example_project/mdyOsc_v1.1/Oscill_main_top/Oscill_sel.v}
vlog -vlog01compat -work work +incdir+C:/FPGA_source/FPGA_MP801/MP801_example_project/mdyOsc_v1.1/Oscill_main_top {C:/FPGA_source/FPGA_MP801/MP801_example_project/mdyOsc_v1.1/Oscill_main_top/Oscill_main_top.v}
vlog -vlog01compat -work work +incdir+C:/FPGA_source/FPGA_MP801/MP801_example_project/mdyOsc_v1.1/Oscill_main_top {C:/FPGA_source/FPGA_MP801/MP801_example_project/mdyOsc_v1.1/Oscill_main_top/Oscill_main.v}
vlog -vlog01compat -work work +incdir+C:/FPGA_source/FPGA_MP801/MP801_example_project/mdyOsc_v1.1/Oscill_main_top {C:/FPGA_source/FPGA_MP801/MP801_example_project/mdyOsc_v1.1/Oscill_main_top/Oscill_adc_clk.v}
vlog -vlog01compat -work work +incdir+C:/FPGA_source/FPGA_MP801/MP801_example_project/mdyOsc_v1.1/Oscill_main_top {C:/FPGA_source/FPGA_MP801/MP801_example_project/mdyOsc_v1.1/Oscill_main_top/my_sin.v}
vlog -vlog01compat -work work +incdir+C:/FPGA_source/FPGA_MP801/MP801_example_project/mdyOsc_v1.1/Oscill_main_top {C:/FPGA_source/FPGA_MP801/MP801_example_project/mdyOsc_v1.1/Oscill_main_top/my_juchi.v}
vlog -vlog01compat -work work +incdir+C:/FPGA_source/FPGA_MP801/MP801_example_project/mdyOsc_v1.1/Oscill_main_top {C:/FPGA_source/FPGA_MP801/MP801_example_project/mdyOsc_v1.1/Oscill_main_top/my_trig.v}
vlog -vlog01compat -work work +incdir+C:/FPGA_source/FPGA_MP801/MP801_example_project/mdyOsc_v1.1/Oscill_main_top {C:/FPGA_source/FPGA_MP801/MP801_example_project/mdyOsc_v1.1/Oscill_main_top/my_rec.v}
vlog -vlog01compat -work work +incdir+C:/FPGA_source/FPGA_MP801/MP801_example_project/mdyOsc_v1.1/Oscill_main_top {C:/FPGA_source/FPGA_MP801/MP801_example_project/mdyOsc_v1.1/Oscill_main_top/multiwave.v}
vlog -vlog01compat -work work +incdir+C:/FPGA_source/FPGA_MP801/MP801_example_project/mdyOsc_v1.1/Oscill_main_top {C:/FPGA_source/FPGA_MP801/MP801_example_project/mdyOsc_v1.1/Oscill_main_top/final_top.v}
vlog -vlog01compat -work work +incdir+C:/FPGA_source/FPGA_MP801/MP801_example_project/mdyOsc_v1.1/Oscill_main_top/db {C:/FPGA_source/FPGA_MP801/MP801_example_project/mdyOsc_v1.1/Oscill_main_top/db/oscill_pll_32m_altpll1.v}

vlog -vlog01compat -work work +incdir+C:/FPGA_source/FPGA_MP801/MP801_example_project/mdyOsc_v1.1/Oscill_main_top {C:/FPGA_source/FPGA_MP801/MP801_example_project/mdyOsc_v1.1/Oscill_main_top/final_top_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  final_top_tb

add wave *
view structure
view signals
run -all
