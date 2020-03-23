vlib work

vcom -93 MUX2.vhd
vcom -93 MUX2_tb.vhd

vsim MUX2_test(test_bench)

view signals
add wave COM
add wave -radix hexadecimal A
add wave -radix hexadecimal B
add wave -radix hexadecimal S

run -all