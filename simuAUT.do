vlib work

vcom -93 EXT.vhd
vcom -93 REG.vhd
vcom -93 MUX2.vhd
vcom -93 UAL.vhd
vcom -93 MEM.vhd
vcom -93 AUT.vhd
vcom -93 AUT_tb.vhd

vsim AUT_test(test_bench)

view signals
add wave CLK
add wave RST
add wave COM1
add wave COM2
add wave WrEn
add wave RegWr
add wave -radix unsigned Rw
add wave -radix unsigned Ra
add wave -radix unsigned Rb
add wave OP
add wave -radix decimal Imm

run -all