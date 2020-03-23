vlib work

vcom -93 IDCU.vhd
vcom -93 IDCU_tb.vhd

vsim IDCU_tb(test_bench)

view signals
add wave -radix hexadecimal PSR
add wave -radix hexadecimal INSTR
add wave nPCsel
add wave RegWr
add wave RegSel
add wave AluSrc
add wave AluCtr
add wave PSRen
add wave MemWr
add wave WrSrc

run -all