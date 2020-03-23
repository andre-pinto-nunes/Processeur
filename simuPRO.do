vlib work

vcom -93 UGI.vhd
vcom -93 AUT.vhd
vcom -93 PSR.vhd
vcom -93 EXT.vhd
vcom -93 IDCU.vhd
vcom -93 PROCESSEUR.vhd
vcom -93 PROCESSEUR_tb.vhd

vsim PRO_test(test_bench)

view signals
add wave CLK
add wave RST

run -all