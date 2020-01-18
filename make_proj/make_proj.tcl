#!/usr/bin/tclsh
# creates a vivado verilog project from a sample project.
# make sure you specify the correct board part down below.
# also make sure vivado is in your PATH.

set SAMPLE_PROJ "./p0_default_project"
set PART "xc7z020clg400-1"
set BOARD_PART "www.digilentinc.com:pynq-z1:part0:1.0"

if { $argc < 1 } {
    # tput adds colors
    puts [exec tput setaf 1]
    puts "SPECIFY PROJECT NAME AS FIRST ARGUMENT"
    puts [exec tput sgr0]
    return
}

set PROJ [lindex $argv 0]
set DIR [pwd]/$PROJ

puts "proj: $PROJ"
puts "dir:  $DIR"

if { [file exists $PROJ] == 1} {
    puts [exec tput setaf 1]
    puts "PROJECT $PROJ ALREADY EXISTS"
    puts [exec tput sgr0]
    return
}

exec cp -r "$SAMPLE_PROJ/" "$DIR/"

set CONSTRAINTS "$DIR/hdl/PYNQ-Z1_C.xdc"
puts "constraints:  $CONSTRAINTS"
if { [file exists $CONSTRAINTS] != 1} {
    puts [exec tput setaf 1]
    puts "CONSTRAINTS DON'T EXIST - ABORT"
    puts "REMOVE THE PROJECT y/\[n\]"
    exec rm -rfI $DIR
    puts [exec tput sgr0]
    return
}

# making a different TCL script because arguments cannot be passed to scripts
# while calling vivado. This is a crappy but widely used practice.
# Please tweak for your board part.
exec echo "
create_project $PROJ $DIR/vivado -part $PART
set_property board_part $BOARD_PART \[current_project\]
set_property simulator_language Verilog \[current_project\]
add_files -fileset constrs_1 -norecurse $CONSTRAINTS
set_property SOURCE_SET sources_1 \[get_filesets sim_1\]
add_files -fileset sim_1 -norecurse $DIR/sim/tb.sv
update_compile_order -fileset sim_1

puts \[exec tput setaf 2\]
puts {Project created!}
puts \[exec tput sgr0\]

start_gui
" > inst_proj.tcl

exec vivado -source inst_proj.tcl
