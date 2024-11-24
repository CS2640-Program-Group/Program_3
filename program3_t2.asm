# Elijah Rosal, Caleb Szeto, Ryan Hansen, Eric Chen, Cameron Bolanos
# CS2640
# 11-24-2024
# Program 3: Accessing Memory and File Handling
# Task 2: Printing Files

.macro closeFile(%reg)
	li $v0, 16
	move $a0, %reg
	syscall
.end_macro

.data
buffer: .space 256
myFile: .asciiz "practiceFile.txt"
.text

main:
	# Open myFile for reading
	li $v0, 13		# System call code for opening a file
	la $a0, myFile		# Load address of the file name into $a0
	la $a1, 0		# Open mode: read-only
	la $a2, 0	
	syscall	
	move $s0, $v0		# Store the file descriptor in $s0
	
	# Read contents of myFile into buffer
	li $v0, 14		# System call code for reading from a file
	move $a0, $s0		# Pass the file descriptor of myFile in $a0
	la $a1, buffer 		# Load address of the buffer to store contents
	li $a2, 256		# Maximum number of bytes to read
	syscall
	
	# Print the contents of myFile to the console
	li $v0, 4		# System call code for printing a string
	la $a0, buffer		# Load address of the buffer containing the file contents
	syscall			# Perform the system call
		
	# Close myFile
	closeFile($s0)		# Call the macro to close myFile

exit:
	# Exit the program
	li $v0, 10		# System call code for program termination
	syscall			# Perform the system call
	
	
	
