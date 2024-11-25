# Elijah Rosal, Caleb Szeto, Ryan Hansen, Eric Chen, Cameron Bolanos
# CS2640
# 11-24-2024
# Program 3: Accessing Memory and File Handling
# Task 3: Append to File

.macro closeFile(%reg)
	li $v0, 16
	move $a0, %reg
	syscall
.end_macro

.macro printing(%str) 	# Macro for printing a given String argument
	li $v0, 4	# Load syscall for print_string
	la $a0, %str	# load the address of the given string
	syscall		# Print String
.end_macro

.macro read_string
# Read the string input (user input)
        li $v0, 8		# Load syscall for read_string
        la $a0, buffer		# Load buffer address
        li $a1, 250		# Specify max length for input (20 characters)
        syscall			# Read the string
.end_macro

.data
buffer: .space 250
myFile: .asciiz "practiceFile.txt"
prompt1: .asciiz "Enter file name: "
prompt2: .asciiz "Answer the question within 250 chracters: \"What have you enjoyed most about the class so far?\"\n"
.text

main:
	# Prompt for file name
	printing(prompt1)
	read_string
	# Open myFile for reading
	li $v0, 13		# System call code for opening a file
	la $a0, myFile		# Load address of the file name into $a0
	la $a1, 9		# Open mode: write-only with create and append
	la $a2, 0	
	syscall	
	move $s0, $v0		# Store the file descriptor in $s0
	
	# Prompt for text to append
	printing(prompt2)
	read_string
	
	# Write the contents of myFile to newFile
	move $a0, $s0		# Pass the file descriptor of newFile in $a0
	li $v0, 15		# System call code for writing to a file
	la $a1, buffer		# Load address of the buffer containing file contents
	la $a2, 250		# Number of bytes to write
	syscall               
		
	# Close myFile
	closeFile($s0)		# Call the macro to close myFile

exit:
	# Exit the program
	li $v0, 10		# System call code for program termination
	syscall			# Perform the system call
	
	
	
