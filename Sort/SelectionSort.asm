#MARS 4.5
#Selection Sort in Mips
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
	li $t3, 0	#$t3 = j
	li $t4, 0
	li $t5, 0
	
	addi $t4, $t0, -1	#$t4 = n - 1
SelectionSort:
	bge $t1, $t4, endSelectionSort
	lw $s0, a($t2)	#min = a[i]
	addi $t3, $t1, 1	#j = i + 1
	addi $t5, $t2, 4
subLoop:
	bge $t3, $t0, endsubLoop
	lw $s1, a($t5)
	blt $s1, $s0, swap	#a[j] = min, swap a[i] and a[j] if a[j] < min
continue:
	addi $t3, $t3, 1
	addi $t5, $t5, 4
	j subLoop
swap:
	sw $s0, a($t5)
	sw $s1, a($t2)
	move $s0, $s1
	j continue
endsubLoop:
	addi $t1, $t1, 1
	addi $t2, $t2, 4
	j SelectionSort
endSelectionSort:
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
	
	