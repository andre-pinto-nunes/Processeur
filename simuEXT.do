vlib work

vcom -93 EXT.vhd
vcom -93 EXT_tb.vhd

vsim EXT_test(test_bench)

view signals
add wave E
add wave S

run -all