.globl main

.data
str1:          .space 1
operation:     .asciiz "Select operation (+, -, *, or /): "
first:         .asciiz "First number: "
second:        .asciiz "Second number: "
answer:        .asciiz "The answer is "
next_line:     .asciiz "\n"
error_message: .asciiz "Incorrect operation \n"

.text
main: 	
	#$t5 is a temporary register to store operation sign(char)
	#$t4 is to stroe retrun adresses 
	
	li $v0 4	# write an operation message
	la $a0 operation
	syscall 
	
	li $v0 8	#read an input as string and store it to str1
	la $a0 str1
	li $a1, 2
	syscall
	
	lb $t5, str1	#load byte(the operation sign) from str1
	
	li $v0 4	# write a next_line message
	la $a0 next_line
	syscall
	
	li $t0 '+'
	li $t1 '-'
	li $t2 '/'
	li $t3 '*'
	beq $t5 $t0 add		# if operation is '+' go to add label
	beq $t5 $t1 sub		# if operation is '-' go to sub label
	beq $t5 $t3 mul		# if operation is '*' go to mul label
	beq $t5 $t2 div		# if operation is '/' go to div label
	
	li $v0 4
	la $a0 error_message	# otherwise write an error_message
	syscall
	j main			# jump back to the start of the main if error  
	
	
add:    
	move $t4 $ra		# save $ra
	jal add_f		# call the add function
	move $ra $t4		# restore $ra
	move $t0 $v0
	j result

sub:  
	move $t4 $ra		# save $ra
	jal sub_f		# call the sub function
	move $ra $t4		# restore $ra 
	move $t0 $v0
	j result
	
mul:
	move $t4 $ra		# save $ra
	jal mul_f		# call the mul function
	move $ra $t4		# restore $ra
	move $t0 $v0
	j result
	
div:   
	move $t4 $ra		# save $ra
	jal div_f		# call the div function
	move $ra $t4		# restore $ra
	move $t0 $v0

result:     	
	li $v0 4	# write answer message
	la $a0 answer
	syscall
	move $a0 $t0
	li $v0 1	# write an integer (answer)
	syscall
	li $v0 10	# exit
	syscall

	# function that adds two integers
	# $t2 is an answer	
	# $t0 is the first integer
	# $t1 is the second integer		
add_f:	
	move $t4 $ra		# save $ra
	jal read_integers	# call the read_integers function
	move $ra $t4		# restore $ra
	move $t0 $v0
	move $t1 $v1
	add $t2 $t0 $t1
	move $v0 $t2
	jr $ra 
	
	# function that subtracts two integers
	# $t2 is an answer	
	# $t0 is the first integer
	# $t1 is the second integer	
sub_f:	
	move $t4 $ra		# save $ra
	jal read_integers 	# call the read_integers function
	move $ra $t4		# restore $ra
	move $t0 $v0 
	move $t1 $v1 
	sub $t2 $t0 $t1
	move $v0 $t2
	jr $ra
	
	# function that multiplies two integers
	# $t2 is an answer	
	# $t0 is the first integer
	# $t1 is the second integer	
mul_f:	
	move $t4 $ra		# save $ra
	jal read_integers 	# call the read_integers function
	move $ra $t4		# restore $ra
	move $t0 $v0
	move $t1 $v1
	mult $t0 $t1
	mflo $t2
	move $v0 $t2
	jr $ra
	
	# function that divides two integers
	# $t2 is an answer	
	# $t0 is the first integer
	# $t1 is the second integer	
div_f:	
	move $t4 $ra		# save $ra
	jal read_integers 	# call the read_integers function
	move $ra $t4		# restore $ra
	move $t0 $v0
	move $t1 $v1
	div $t2 $t0 $t1
	move $v0 $t2
	jr $ra


	# function that reads two integers 
	# t0 is the first integer
	# t1 is the second integer
read_integers: 						
		li $v0 4 	# write first message
		la $a0 first
		syscall
		li $v0 5	# read the first integer
		syscall
		move $t0 $v0
		li $v0 4	# write second message
		la $a0 second
		syscall
		li $v0 5 	# read the second integer
		syscall 
		move $t1 $v0
		move $v0 $t0
		move $v1 $t1 
		jr $ra
		
