#include <iregdef.h>


.data
newLine: .asciiz "new line\n"
arrayPrint: .asciiz "%d "
array: .word 4,5,2,2,1,6,7,9,5,10
antal: .word 10



.text
.set noreorder
.globl skriv			
.ent skriv

skriv:
	subu sp,sp,24			//flyttar stackpekaren
	sw ra,20(sp)       //sparar returadresssen

	move s0, zero
	la a0,arrayPrint
	la t1,array //töms temp reg vid jal printf??? 
	L1:
	bge s0,10,L2	
	sll t2,s0,2 //håller koll på att t2=4*i(i=s0)
	add t2,t1,t2
	lw t2,0(t2) //skriver över adressen med värdet på den platsen
	nop
	move a1,t2
	jal printf
	nop
	addi s0,s0,1
	b L1
	nop


	L2:
	lw ra,20(sp) // laddar in returadressen
	addiu sp,sp,24 //flyttar tillbaka stackpekaren
	jr ra
	nop
	.end skriv
	
.globl quicksort
.ent quicksort

quicksort:
	subu sp, sp, 24
	sw ra,20(sp)
	
	lw s0,antal 
	subu s0,s0,1
	
	
	
	LS1:
	bge s0,zero,LS2      // Om t2<t1 go to LS2
	jal partition
	nop
	
	
	b LS1
	nop
	
	
	
	LS2:
	lw ra, 20(sp)
	addiu sp,sp,24
	.end quicksort


.globl partition
.ent partition

partition:
	subu sp,sp,24
	sw ra,20(sp)
	
	/// t0(adress till array), pivot t3, a--->s0, v[lower] s1 (nästa värde [a+1] från pivot), upper(k) s2 (antal-1)
	// s0=antal-1 (skriven i quicksort)
	
	la t0,array //t0 blir adress till array[0]
	
	la t1,array //pivot ska bli t1, behöver första adressen senare

	//s0*4	
	li t2,0 
	sll t2,t2,2
	addu t1,t2
	lw t3,0(t1)
	lw s1,4(t1) //s1 = v[lower]
	addu t1,4 //lower
	
	
	LP1:
//	bge  
//	bge

	b LP1
	nop
	
	
	LP2:


	LP3:	
	lw ra, 20(sp)
	addiu sp,sp,24
	.end partition



.globl start
.ent start

start:

	subu sp,sp,24
	sw ra,20(sp)
	
	
	jal skriv		//kör subrutinen skriv
	nop
	jal quicksort
	nop
	lw s2,antal
	subu s2, 1
	li s0,0
	
	
	
	lw ra,20(sp) //laddar in returadressen
	addiu sp,sp,24 //flyttar stackpekaren
	jr ra
	nop
	.end start
