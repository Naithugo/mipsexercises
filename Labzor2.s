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

	move t3, zero
	la a0,arrayPrint
	la t1,array //töms temp reg vid jal printf??? 
	L1:
	bge t3,10,L2	
	sll t2,t3,2 //håller koll på att t2=4*i(i=s0)
	add t2,t1,t2
	lw t2,0(t2) //skriver över adressen med värdet på den platsen
	nop
	move a1,t2
	jal printf
	nop
	addi t3,t3,1
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
	
	LS1:
	bge s2,s0,LS2      // Om t2<t1 go to LS2
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
	// s2 (b) =antal-1 (skriven i start) s0= 0 i main
	
	la t0,array //t0 blir adress till array[0]
	
	la t1,array //pivot ska bli t1, behöver första adressen senare

	//s0*4	
//	li t2,0 
//	sll t2,t2,2
//	addu t1,t2
	
	li t6,4
	mult s0,t6 // multiplicerar [a] med 4 för att få rätt plats i arrayen
	mflo t6 
	addu t1,t1,t6 //
	lw t3,0(t1) //v[a] hamnar i t3 (pivot)
	lw s1,4(t1) //s1 = v[lower]
	addu t1,4 //lower
	
	
	LP1:
	bgt s1,t3, LP2  // om v[lower]>pivot, hoppa till LP2
	blt t1,s2, LP2 // om lower < upper, hoppa till LP2
	
	
	b LP1
	nop
	
	
	LP2:
	
	
	
	b LP3

	LP3:	
	lw ra, 20(sp)
	addiu sp,sp,24
	.end partition



.globl start
.ent start

start:

	subu sp,sp,24
	sw ra,20(sp)
	lw s2,antal
	subu s2, 1
	li s0,0
	
	
	jal skriv		//kör subrutinen skriv
	nop
	jal quicksort
	nop
	
	
	
	
	lw ra,20(sp) //laddar in returadressen
	addiu sp,sp,24 //flyttar stackpekaren
	jr ra
	nop
	.end start
