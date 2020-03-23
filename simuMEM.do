vlib work

vcom -93 MEM.vhd
vcom -93 MEM_tb.vhd

vsim MEM_test(test_bench)

view signals
add wave Clk
add wave WrEn
add wave -radix unsigned Addr
add wave -radix hexadecimal DataIn
add wave -radix hexadecimal DataOut

run -all