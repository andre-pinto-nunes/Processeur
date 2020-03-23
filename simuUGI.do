vlib work

vcom -93 MEM.vhd
vcom -93 EXT.vhd
vcom -93 REGN.vhd
vcom -93 UGI.vhd
vcom -93 UGI_tb.vhd

vsim UGI_tb(bench)

view signals
add wave Clk
add wave rst
add wave nPCsel
add wave -radix decimal offset
add wave -radix hexadecimal instr

run -all