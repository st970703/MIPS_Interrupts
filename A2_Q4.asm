# Assignment 02-Q4
# elee353, 840454023
# enable further interrupts

......

# $k1 is used because it should persist data between ISR calls.
mfc0 $k1, $12
# set Interrupt Enable (bit 0) to 1
ori $k1, $t0, 0x0001
mtc0 $k1, $12

......