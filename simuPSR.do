vlib work

vcom -93 PSR.vhd
vcom -93 PSR_tb.vhd

vsim PSRtest(testbench)

view signals
add wave CLK
add wave RST
add wave WE
add wave -radix hexadecimal DATAIN
add wave -radix hexadecimal DATAOUT

run -all