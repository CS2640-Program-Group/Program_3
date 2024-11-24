# Elijah Rosal, Caleb Szeto, Ryan Hansen, Eric Chen, Cameron Bolanos
# CS2640
# 11-24-2024
# Program 3: Accessing Memory and File Handling
# Task 1: Return a Letter Grade from Scores in Memory

.macro printing(%str) 	# Macro for printing a given String argument
	li $v0, 4	# Load syscall for print_string
	la $a0, %str	# load the address of the given string
	syscall		# Print String
.end_macro

.data
grade_msg: .asciiz "\nThe grade for "
is_msg: .asciiz " is: "
Agrade: .asciiz "A"
Bgrade: .asciiz "B"
Cgrade: .asciiz "C"
Dgrade: .asciiz "D"
Fgrade: .asciiz "F"
extra_msg: .asciiz " with Extra Credit"
exit_msg: .asciiz "\nThe program will now exit."
array: .word 32, 56, 78, 66, 88, 90, 93, 100, 101, 82
array_len: .word 10
.text

main:
	li $s0, 0		# Initialise the element counter
	la $t0, array		# Load the address for array into $t0
	la $s1, array_len	# Load the address for array_len into $s1
	lw $s2, 0($s1)		# Load the value of array_len into $s2
loop:
	lw $t1, 0($t0)		# Load int from array
	beq $s0, $s2, exit	# Once the counter matches the value in array_len, exit loop
	printing(grade_msg)
	move $a0, $t1		# Load the value into $a0 for printing
	li $v0, 1		# Load syscall for print_int
	syscall			# Print the value
	printing(is_msg)
	bgt $t1, 100, extra	
	bge $t1, 90, A
	bge $t1, 80, B
	bge $t1, 70, C
	bge $t1, 60, D
	blt $t1, 60, F

extra:
	printing(Agrade)
	printing(extra_msg)
	addi $s0, $s0, 1		# Increment the counter
	addi $t0, $t0, 4		# Move to the next integer in the array
	j loop
A:
	printing(Agrade)
	addi $s0, $s0, 1		# Increment the counter
	addi $t0, $t0, 4		# Move to the next integer in the array
	j loop
B:
	printing(Bgrade)
	addi $s0, $s0, 1		# Increment the counter
	addi $t0, $t0, 4		# Move to the next integer in the array
	j loop
C:
	printing(Cgrade)
	addi $s0, $s0, 1		# Increment the counter
	addi $t0, $t0, 4		# Move to the next integer in the array
	j loop
D:
	printing(Dgrade)
	addi $s0, $s0, 1		# Increment the counter
	addi $t0, $t0, 4		# Move to the next integer in the array
	j loop
F:
	printing(Fgrade)	
	addi $s0, $s0, 1		# Increment the counter
	addi $t0, $t0, 4		# Move to the next integer in the array
	j loop

exit: 
	printing(exit_msg)
	li $v0, 10	# Load syscall for exit
	syscall		# Exit the program
	