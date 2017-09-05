# Assignment 02-Q1
# elee353, 840454023
# measure pulse width

.ktext 0x8000 0180

# $t1 is 1
addi $t1, $0, 1

# $k0 is edge flag: 0 for rising, 1 for falling
# assumed to be zero (rising edge) inititially
# stop timer if falling edge (in L1)
beq $k0, $t1, L1

# start timer
sw $0, count_prog($0)
# set edge flag to falling for next iteration
andi $k0, $0, 1

j L2


L1:
# external interrupt occured at falling edge
# Stop the counter
li $t1, 0xFFFF FFFF
sw $t1, count_prog($0)

# set edge flag to rising
ori $k0, $0, 0

# $t7 = read number of cycles
la $t1, count_read($0)
lw $t7, 0($t1)
# store to pulse_width
sw $t7, pulse_width($0)

L2:
eret