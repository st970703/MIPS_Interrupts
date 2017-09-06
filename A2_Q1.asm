# Assignment 02-Q1
# elee353, 840454023
# measure pulse width

.ktext 0x8000 0180

# $t1 is 1
addi $t1, $0, 1

# $k0 is edge flag: 0 for rising, 1 for falling
# edge flag is in kernel, so it should persist between ISR calls.
# edge flage assumed to be zero (rising edge) inititially
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
# enable further interrupt.
mfc0 $k1, $12
ori $k1, $t0, 0x0001
mtc0 $k1, $12

eret


		.kdata
		.align 2
tmp0:	.word 0

--------------
# save content of $a0 for backup
sw $a0, tmp0

# find the exception number
# copy Cause Resigter into $a0
mfc0 $a0, $13
# mask unwanted bits
andi $a0, $a0, 007C
# shift right 2 bits to find exception number
srl $a0, $a0, 2




