#MARS 4.5
#Input Matix
#Author: Duynt

.data
	row: .asciiz "Enter number of row: "
	col: .asciiz "Enter number of column: "
	start: .asciiz "\na["
	betw: .asciiz "]["
	end: .asciiz "] = "
	result: .asciiz "\nOutput: \n"
	endl: .asciiz "\n"
	tab: .asciiz "  "
	a: .word 0:100

.text
	la $a0, row
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	move $t1, $v0	#t1 = row
	la $a0, col
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	move $t2, $v0	#t2 = col
	mul $t0, $t1, $t2	#t0 = size of matrix

	li $t3, 0	#t3 = i(row)
	li $t4, 0	#t4 = j(col)
	li $t5, 0
Input:
	la $a0, start
	li $v0, 4
	syscall
	move $a0, $t3
	li $v0, 1
	syscall
	la $a0, betw
	li $v0, 4
	syscall

	move $a0, $t4
	li $v0, 1
	syscall
	la $a0, end
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	sw $v0, a($t5)
	addi $t4, $t4, 1
	addi $t5, $t5, 4
	blt $t4, $t2, Input

	li $t4, 0
	addi $t3, $t3, 1
	blt $t3, $t1, Input

	li $t3, 0	#t3 = i(row)
	li $t4, 0	#t4 = j(col)
	li $t5, 0
	la $a0, result
	li $v0, 4
	syscall
Output:
	la $a0, tab
	li $v0, 4
	syscall
subLoop:
	lw $a0, a($t5)
	li $v0, 1
	syscall

	la $a0, tab
	li $v0, 4
	syscall

	addi $t4, $t4, 1
	addi $t5, $t5, 4
	blt $t4, $t2, subLoop

	la $a0, endl
	li $v0, 4
	syscall

	li $t4, 0
	addi $t3, $t3, 1
	blt $t3, $t1, Output

Exit:
	li $v0, 10
	syscall