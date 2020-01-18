
create_project test_test /home/popi/local/scripts/verilog/cli_scripts/make_proj/test_test/vivado -part xc7z020clg400-1
set_property board_part www.digilentinc.com:pynq-z1:part0:1.0 [current_project]
set_property simulator_language Verilog [current_project]
add_files -fileset constrs_1 -norecurse /home/popi/local/scripts/verilog/cli_scripts/make_proj/test_test/hdl/PYNQ-Z1_C.xdc
set_property SOURCE_SET sources_1 [get_filesets sim_1]
add_files -fileset sim_1 -norecurse /home/popi/local/scripts/verilog/cli_scripts/make_proj/test_test/sim/tb.sv
update_compile_order -fileset sim_1

puts [exec tput setaf 2]
puts {Project created!}
puts [exec tput sgr0]

start_gui

