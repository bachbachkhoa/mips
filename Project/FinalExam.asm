#########################################################
#########	Chuong trinh xu ly chuoi so	#########
#########	Author: Duynt			#########
#########	MARS 4.5			#########
#########################################################


.data
	bd1: .asciiz "\n#########################################################"
	bd2: .asciiz "\n#########	Chuong trinh xu ly chuoi so	#########"
	bd3: .asciiz "\n#########	Author: Duynt			#########"
	bd4: .asciiz "\n#########	MARS 4.5			#########"
	n: .asciiz "\n\nNhap so phan tu cua chuoi: "
	start_element: .asciiz "\na["
	end_element: .asciiz "] = "
	separate: .asciiz "  "
	chuoibd: .asciiz "\nChuoi vua nhap:  "
	chuoiSapXep: .asciiz "\nBubble Sort:  "
	max: .asciiz "\nGia tri lon nhat cua day: "
	min: .asciiz "\nGia tri nho nhat cua day: "
	tong: .asciiz "\nTong cac so trong day: "
	xoatrungnhau: .asciiz "\nMang sau khi xoa cac phan tu trung nhau: "
	Menu: .asciiz "\n#########		    Menu		        #"
	LuaChon1: .asciiz "\n#########	1. Sap xep chuoi voi Buble Sort	        #"
	LuaChon2: .asciiz "\n#########	2. Tim phan tu lon nhat, nho nhat       #"
	LuaChon3: .asciiz "\n#########	3. Tinh tong cac phan tu                #"
	LuaChon4: .asciiz "\n#########	4. Xoa cac phan tu trung nhau	        #"
	LuaChon5: .asciiz "\n#########	5. Nhap mot chuoi moi                   #"
	LuaChon6: .asciiz "\n#########	6. Thoat chuong trinh	                #"
	luachon: .asciiz "\n\nLua chon cua ban: "
	tiepTuc: .asciiz "\n\nBan muon tiep tuc su dung chuong trinh?(c/k)"
	a: .word 0:100
	c: .word 0:100

.text
	#Bat dau chuong trinh
	la $a0, bd1
	li $v0, 4
	syscall
	la $a0, bd2
	li $v0, 4
	syscall
	la $a0, bd3
	li $v0, 4
	syscall
	la $a0, bd4
	li $v0, 4
	syscall
	la $a0, bd1
	li $v0, 4
	syscall

	#Nhap so phan tu cua chuoi
Nhapn:
	la $a0, n
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	ble $v0, $0, Nhapn
	move $t0, $v0	#Luu n vao t0

	li $t1, 0
	li $t2, 0

#Nhap chuoi
Input:
	la $a0, start_element	#in a[
	li $v0, 4
	syscall
	move $a0, $t1			#in chi so mang
	li $v0, 1
	syscall
	la $a0, end_element		#in ] = 
	li $v0, 4
	syscall
	li $v0, 5				#nhap so nguyen
	syscall
	sw $v0, a($t2)			#Luu so vua nhap vao stack
	addi $t1, $t1, 1
	addi $t2, $t2, 4
	blt $t1, $t0, Input

	la $a0, chuoibd
	li $v0, 4
	syscall
	
	li $t1, 0
	li $t2, 0

#Xuat chuoi vua nhap
Output:
	lw $a0, a($t2)
	li $v0, 1
	syscall
	la $a0, separate
	li $v0, 4
	syscall
	addi $t1, $t1, 1
	addi $t2, $t2, 4
	blt $t1, $t0, Output

menu:
	la $a0, bd1
	li $v0, 4
	syscall
	la $a0, Menu
	li $v0, 4
	syscall
	la $a0, LuaChon1
	li $v0, 4
	syscall
	la $a0, LuaChon2
	li $v0, 4
	syscall
	la $a0, LuaChon3
	li $v0, 4
	syscall
	la $a0, LuaChon4
	li $v0, 4
	syscall
	la $a0, LuaChon5
	li $v0, 4
	syscall
	la $a0, LuaChon6
	li $v0, 4
	syscall
	la $a0, bd1
	li $v0, 4
	syscall

Nhapluachon:
	la $a0, luachon
	li $v0, 4
	syscall
	li $v0, 12
	syscall

	beq $v0, 49, BubleSort
	beq $v0, 50, MaxMin
	beq $v0, 51, Sum
	beq $v0, 52, TrungNhau
	beq $v0, 53, Nhapn
	beq $v0, 54, Exit
	j Nhapluachon

BubleSort:
	li $t1, 0	#$t1 = i
	li $t2, 0
	li $t4, 0	#$t4 = j
	li $t6, 4
	addi $t3, $t0, -1	#t3 = n - 1

	mainLoop:
	bge $t1, $t3, endmainLoop	#if i >= n - 1 then end main loop
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
	j mainLoop
	endmainLoop:
	la $a0, chuoiSapXep
	li $v0, 4
	syscall
	li $t1, 0
	li $t2, 0
	Sort:
	lw $a0, a($t2)
	li $v0, 1
	syscall
	la $a0, separate
	li $v0, 4
	syscall
	addi $t1, $t1, 1
	addi $t2, $t2, 4
	blt $t1, $t0, Sort

	#Co muon tiep tuc dung chuong trinh???
	la $a0, tiepTuc
	li $v0, 4
	syscall
	li $v0, 12
	syscall
	beq $v0, 99, menu
	j Exit

MaxMin:
	#Tim max
	li $t1, 0
	li $t2, 1
	li $t3, 4
	lw $s1, a($t1)	#max = s1 = a[0]
	maxLoop:
	bge $t2, $t0, endmaxLoop
	lw $s0, a($t3)
	bgt $s0, $s1, assignMax
	continue1:
	addi $t2, $t2, 1
	addi $t3, $t3, 4
	j maxLoop
	assignMax:
	move $s1, $s0	#max = a[i]
	j continue1
	endmaxLoop:
	la $a0, max
	li $v0, 4
	syscall
	move $a0, $s1
	li $v0, 1
	syscall

	#Tim min
	li $t1, 0
	li $t2, 1
	li $t3, 4
	lw $s1, a($t1)	#min = s1 = a[0]
	minLoop:
	bge $t2, $t0, endminLoop
	lw $s0, a($t3)
	blt $s0, $s1, assignMin
	continue2:
	addi $t2, $t2, 1
	addi $t3, $t3, 4
	j minLoop
	assignMin:
	move $s1, $s0	#min = a[i]
	j continue2
	endminLoop:
	la $a0, min
	li $v0, 4
	syscall
	move $a0, $s1
	li $v0, 1
	syscall

	#Co muon tiep tuc dung chuong trinh???
	la $a0, tiepTuc
	li $v0, 4
	syscall
	li $v0, 12
	syscall
	beq $v0, 99, menu
	j Exit

Sum:
	li $t1, 0
	li $t2, 0
	li $s0, 0
	li $s1, 0
	SumLoop:
	bge $t1, $t0, endSumLoop
	lw $s1, a($t2)
	add $s0, $s0, $s1
	addi $t1, $t1, 1
	addi $t2, $t2, 4
	j SumLoop
	endSumLoop:
	#In tong
	la $a0, tong
	li $v0, 4
	syscall
	move $a0, $s0
	li $v0, 1
	syscall

	#Co muon tiep tuc dung chuong trinh???
	la $a0, tiepTuc
	li $v0, 4
	syscall
	li $v0, 12
	syscall
	beq $v0, 99, menu
	j Exit

TrungNhau:

	li $t1, 0
	li $t2, 0
	li $s0, 0

	newArray:
	bge $t1, $t0, endnewArray
	lw $s0, a($t2)
	sw $s0, c($t2)
	addi $t1, $t1, 1
	addi $t2, $t2, 4
	j newArray

	endnewArray:
	li $t1, 0	# i = t1
	li $t2, 0
	li $t3, 0	# j = t3
	li $t4, 0
	li $t5, 0	# k = t5
	li $t6, 0
	li $t8, 0
	move $t7, $t0
	li $s0, 0
	li $s1, 0

	mainLoopTN:
	bge $t1, $t7, endmainLoopTN
	li $t3, 0
	li $t4, 0
	subLoopTN1:
	bge $t3, $t1, endsubLoopTN1
	lw $s0, c($t2)
	lw $s1, c($t4)
	beq $s1, $s0, DK
	addi $t3, $t3, 1
	addi $t4, $t4, 4
	j subLoopTN1
	j endsubLoopTN1
	DK:
	addi $t5, $t3, 1	# k = j + 1
	addi $t6, $t4, 4
	subLoopTN2:
	bge $t5, $t7, endsubLoopTN2
	addi $t8, $t6, -4
	lw $s0, c($t6)
	sw $s0, c($t8)
	addi $t5, $t5, 1
	addi $t6, $t6, 4
	j subLoopTN2
	endsubLoopTN2:
	addi $t1, $t1, -1
	addi $t2, $t2, -4
	addi $t7, $t7, -1
	addi $t3, $t3, 1
	addi $t4, $t4, 4
	j subLoopTN1
	endsubLoopTN1:
	addi $t1, $t1, 1
	addi $t2, $t2, 4
	j mainLoopTN
	endmainLoopTN:
	li $t1, 0
	li $t2, 0
	li $s0, 0

	la $a0, xoatrungnhau
	li $v0, 4
	syscall 
	XuatTrungNhau:
	lw $a0, c($t2)
	li $v0, 1
	syscall
	la $a0, separate
	li $v0, 4
	syscall
	addi $t1, $t1, 1
	addi $t2, $t2, 4
	blt $t1, $t7, XuatTrungNhau

	#Co muon tiep tuc dung chuong trinh???
	la $a0, tiepTuc
	li $v0, 4
	syscall
	li $v0, 12
	syscall
	beq $v0, 99, menu
	j Exit

Exit:
	li $v0, 10
	syscall