# Assignment 02-Q4
# elee353, 840454023
# enable further interrupts

...
mfc0 $t0, $12
# set Interrupt Enable (bit 0) to 1
addi $t0, $t0, 0x0001
mtc0 $t0, $12
...

