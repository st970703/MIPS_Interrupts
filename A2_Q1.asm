# Assignment 02-Q1
# elee353, 840454023
# measure pulse width

# Assumption: 
# assume both count_prog and count_read can be used to offset from memory address 0.

.ktext 0x8000 0180

# find the exception number
# copy Cause Register into $k1
# use k1 so we don't need to restore the value
# assume $k1 initially 0
mfc0 $k1, $13
# mask unwanted bits
andi $k1, $k1, 0x007C
# don't shift right because the content should be all zeros.

# check if exception is external interrupt
# skip if not external interrupt
bne $0, $k1, L2


# $k0 is edge flag: 0 for rising, 1 for falling
# edge flag is in kernel, so it should persist between ISR calls.
# edge flag assumed to be zero (rising edge) initially
# stop timer if falling edge (in L1)
# $k0 is assumed to be 0 initially
bne $k0, $0, L1

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
# assume eret will re-enable future interrupts


# when the first interrupt occurs, the instructions executed before starting timer are:
# mfc0, andi, bne, bne, sw
# These total to 4+4+3+3+4 = 18 cycles

# when the second interrupt occurs at a falling edge, the instructions executed before stopping timer are:
# mfc0, andi, bne, bne, li, sw
# These total to 4+4+3+3+4+4 = 22 cycles

# Difference in cycles = 22-18 = 4 cycles
# Inaccuracy = 4*10 = 40 nanoseconds.