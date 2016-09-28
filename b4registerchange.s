#include <iregdef.h>


.data
newLine: .asciiz "new line\n"
arrayPrint: .asciiz "%d "
array: .word 4,5,2,2,1,6,1,9,5,3
antal: .word 10

// 4,5,2,2,1,6,7,9,5,10

.text
.set noreorder
.globl skriv			
.ent skriv

skriv:
	subu sp,sp,24			//flyttar stackpekaren
	sw ra,20(sp)       //sparar returadresssen

	move t3, zero
	la a0,arrayPrint
	L1:
	bge t3,10,L2	
	nop
	sll t2,t3,2 //håller koll på att t2=4*i(i=s0)
	add t2,s1,t2
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
	nop
	addiu sp,sp,24 //flyttar tillbaka stackpekaren
	nop
	jr ra
	nop
	.end skriv
	
.globl quicksort
.ent quicksort

quicksort:
	subu sp, sp, 24
	sw ra,20(sp)
	
	
	
	LS1:
	bge s0,s2,LS2      // Om a>=b go to LS2    
	nop
	jal partition
	nop
	move s7, s2		// k
	nop
	addi s2,s7,-1
	nop
	
  
	jal quicksort
	nop
	addi s0,s7,1
	nop
//	move s2,
	
	jal quicksort
	nop
	
	
	
	
	
	LS2:
	lw ra, 20(sp)
	nop
	addiu sp,sp,24
	nop
	jr ra
	nop
	.end quicksort


.globl partition
.ent partition

partition:
	
	subu sp,sp,24
	sw ra,20(sp)
	
	/// t0(adress till array), pivot t3, a--->s0, v[lower] s1 (nästa värde [a+1] från pivot), upper(k) s2 (antal-1)
	// s2 (b) =antal-1 (skriven i start) s0= 0 i main
	
	la s1,array //t0 blir adress till array[0]
	
	//la t1,array //används för att få fram pivot

	
	
	li t6,4
	nop
	multu s0,t6 // multiplicerar [a] med 4 för att få rätt plats i arrayen
	nop
	mflo t6 
	nop
	addu t1,s1,t6 // få adress till v[a] 
	nop
	lw t3,0(t1) //v[a] hamnar i t3 (pivot)
	nop
	lw t4,4(t1) //t4 = v[lower]
	nop
	addu t9,t1,4   //lower=t9  (t9 = a+1)
	nop
	
	
	li t7,4
	nop
	multu s2,t7
	nop
	mflo s4
	nop
	addu s4,s1,s4        //upper: adress till v[upper]
	nop
	
	lw t7,0(s4) 		//fixar v[upper]s värde				//Upper (0-9) är s2 (b)
	nop
	
	LP1:
	bgt t4,t3, LP2  // om v[lower]>pivot, hoppa till LP2
	nop
	bgt t9,s4, LP2 // om lower > upper, hoppa till LP2
	nop
	addi t9,t9,4
	nop
	lw t4,0(t9)
	nop
	b LP1
	nop
	
	
	LP2:
	ble t7,t3,LP3			//om v[upper] =< pivot hoppa till LP3
	nop
	bgt t9,s4,LP3			//om lower > upper hoppa till LP3
	nop
	addi s4,s4,-4
	nop
	addi s2,s2,-1
	nop
	lw t7,0(s4)
	nop
	
	b LP2
	nop
	


	LP3:
	bgt t9,s4,LP4
	nop
	
	move t8,t4      //temp = v[lower]
	nop
	
	move t4,t7		// v[lower] = v[upper]
	nop
	sw t4, 0(t9)
	nop
	
	move t7,t8		// v[upper] = temp
	nop
	sw t7,0(s4)
	nop
	
	addi t9,t9,4	// lower = lower +1
	nop
	addi s4,s4,-4	// upper = upper -1
	nop
	addi s2,s2,-1
	nop
	lw t7,0(s4)
	nop
	lw t4,0(t9)
	nop
	
	
	LP4:
	ble t9,s4,LP1
	nop
	
	
	move t8,t7				//t8 är temp
	nop
	
	move t7,t3
	nop
	sw t7,0(s4)
	nop
	
	move t3,t8
	nop
	sw t3,0(t1)	
	nop
	
	lw ra, 20(sp)
	nop
	addiu sp,sp,24
	nop
	jr ra
	nop
	.end partition
	



.globl start
.ent start

start:

	subu sp,sp,24
	nop
	sw ra,20(sp)
	nop
	la s1,array
	nop
	lw s2,antal //upper (kallas b här)
	nop
	addiu s2, s2,-1
	nop 
	li s0,0  // a
	nop
	
	jal skriv		//kör subrutinen skriv
	nop
	jal quicksort
	nop
	jal skriv
	nop
	
	
	lw ra,20(sp) //laddar in returadressen
	nop
	addiu sp,sp,24 //flyttar stackpekaren
	nop
	jr ra
	nop
	.end start
