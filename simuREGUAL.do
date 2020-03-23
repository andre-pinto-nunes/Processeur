vlib work

vcom -93 REG.vhd
vcom -93 UAL.vhd
vcom -93 REGUAL.vhd
vcom -93 REGUAL_tb.vhd

vsim REGUAL_tb(bench)

view signals
add wave clk
add wave rst
add wave -radix unsigned ra
add wave -radix unsigned rb
add wave op
add wave -radix unsigned rw
add wave we
add wave n

run -all