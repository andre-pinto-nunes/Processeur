vlib work

vcom -93 REG.vhd
vcom -93 REG_tb.vhd

vsim REG_tb(bench)

view signals
add wave clk
add wave rst
add wave -radix hexadecimal w
add wave -radix unsigned ra
add wave -radix unsigned rb
add wave -radix unsigned rw
add wave we
add wave -radix hexadecimal a
add wave -radix hexadecimal b

run -all