#MARS 4.5
#Bubble Sort in Mips
#Author: Duynt

.data
	n: .asciiz "Enter the number of elements of the array: "
	start: .asciiz "\na["
	end: .asciiz "] = "
	separate: .asciiz "  "
	fResult: .asciiz "\nArray just entered: "
	sResult: .asciiz "\nThe array is sorted: "
	a: .word 0:100

.text
	la $a0, n
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	move $t0, $v0 #save n on $t0
	
	li $t1, 0
	li $t2, 0
	
#Input and output of first array
Input:
	la $a0, start
	li $v0, 4
	syscall
	move $a0, $t1
	li $v0, 1
	syscall
	la $a0, end
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	sw $v0, a($t2)
	addi $t1, $t1, 1
	addi $t2, $t2, 4
	blt $t1, $t0, Input
	
	la $a0, fResult
	li $v0, 4
	syscall
	
	li $t1, 0
	li $t2, 0
fOutput:
	lw $a0, a($t2)
	li $v0, 1
	syscall
	la $a0, separate
	li $v0, 4
	syscall
	addi $t1, $t1, 1
	addi $t2, $t2, 4
	blt $t1, $t0, fOutput

	li $t1, 0	#$t1 = i
	li $t2, 0
	li $t4, 0	#$t4 = j
	li $t6, 4	
#Output of sorted array
	addi $t3, $t0, -1	#$t3 = n - 1
BubbleSort:
	bge $t1, $t3, endBubbleSort	#$t1 = i
	sub $t5, $t3, $t1	#t5 = n - i - 1
subLoop:
	bge $t4, $t5, endsubLoop
	lw $s0, a($t2)	#$s0 = a[j]
	lw $s1, a($t6)	#$s1 = a[j + 1]
	bgt $s0, $s1, swap #swap a[j] and a[j + 1] if a[j] > a[j + 1]
continue:
	addi $t4, $t4, 1
	addi $t2, $t2, 4
	addi $t6, $t6, 4
	j subLoop
swap:
	sw $s1, a($t2)
	sw $s0, a($t6)
	j continue
endsubLoop:
	li $t4, 0
	li $t2, 0
	li $t6, 4
	addi $t1, $t1, 1
	j BubbleSort
endBubbleSort:

	la $a0, sResult
	li $v0, 4
	syscall

	li $t1, 0
	li $t2, 0
sOutput:
	lw $a0, a($t2)
	li $v0, 1
	syscall
	la $a0, separate
	li $v0, 4
	syscall
	addi $t1, $t1, 1
	addi $t2, $t2, 4
	blt $t1, $t0, sOutput

Exit:
	li $v0, 10
	syscall
