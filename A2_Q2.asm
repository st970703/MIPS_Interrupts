# Assignment 02- Q2
# (a)
# ARM 
# (i)
# load base address of table
ori $t0, $0, 1024
# initialize loop counter
ori $t1, $0, 200
# clear $t3 (using $t3 XOR $t3)
xor $t3, $t3, $t3

L1:
# get first addition operand
lw $t4, 0($t0)
# add to r2
add $t3, $t3, $t4
# increment to next table element
addi $t0, $t0, 4
# decrement loop counter
addi $t1, $t1, -1
# if loop counter is not 0, go to L1
bne $0, $t1, L1

(ii)
# r1 = r2 3:0 concatenated with r2 31:4
# $t3 and $t4 are temporaty registers
# shift left by 7 bytes (rotate)
sll $t3, $t2, 28
# shift right by 1 bytes (shift)
srl $t4, $t2, 4
# combine $t4 and $t3
or $t1, $t3, $t4

# (b)
Average instruction execution time = Clock period * Average CPI
(i)
How much faster (ARM/MIPS)
= (ARM CPU performance)/(MIPS CPU Performance)
= (MIPS Execution Time)/(ARM Execution Time)
= (MIPS -> Instruction count*CPI*Clock cycle time)/(ARM -> Instruction count*CPI*Clock cycle time)
= (8*CPI*(1/1.5))/(8*CPI) = 0.67

The ARM CPU perfomance is 0.67 times the speed of MIPS'.

(ii)
How much faster (ARM/MIPS)
= (ARM CPU performance)/(MIPS CPU Performance)
= (MIPS Execution Time)/(ARM Execution Time)
= (MIPS -> Instruction count*CPI*Clock cycle time)/(ARM -> Instruction count*CPI*Clock cycle time)
= (3*CPI*(1/1.5))/(1*CPI) = 2

The ARM CPU perfomance is 2 times faster than MIPS'.