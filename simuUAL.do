vlib work

vcom -93 UAL.vhd
vcom -93 UAL_tb.vhd

vsim UAL_TEST(test_bench)

view signals
add wave OP
add wave -radix decimal A
add wave -radix decimal B
add wave -radix decimal S
add wave N

run -all