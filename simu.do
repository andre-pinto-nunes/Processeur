vlib work

vcom -93 ../src/registres.vhd
vcom -93 registres_tb.vhd

vsim registres_tb(Bench)

view signals
add wave clk
add wave rst
add wave -radix unsigned ra
add wave -radix unsigned rb
add wave -radix unsigned rw
add wave -radix hexadecimal w
add wave -radix hexadecimal a
add wave -radix hexadecimal b

run -all