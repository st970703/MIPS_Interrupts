# Assignment 02-Q1
# elee353, 840454023
# measure pulse width
		.data
		.align	2
	# Set e_flag to 0 (external interrupt) 
	e_flag: .word	0
message 1: .asciiz " \n"

main:
# $t6 = edge flag
# 0 for rising, 1 for falling
# set edge flag to rising
ori $t6, $0, 0

L1:
# Assume no exception and set e_flag to 0xFF
ori $t0, $0, 0xFF
#set e_flag to 0xFF
sw $t0, e_flag

# Exception handler
lw $t4, e_flag
ori $t5, $0, 0
beq $t4, $t5, L2

j L1

L2:
# check if external interrupt occured at rising edge
beq $t6, $0, L3
# external interrupt occured at falling edge
# Set edge flag to rising
ori $t6, $0, 0

# Initialize and start counter
la $t1, count_prog
lw $t2, 0($t1)
li $t2, 0x0000 0000
sw $t2, 0($t1)

j L1

L3:
# external interrupt occured at rising edge
# Set edge flag to rising
ori $t6, $0, 1

# Stop the counter
la $t1, count_prog
lw $t2, 0($t1)
li $t2, 0xFFFF FFFF
sw $t2, 0($t1)

# $t7 = read number of cycles
la $t1, count_read
lw $t7, 0($t1)