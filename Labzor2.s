#include <iregdef.h>


.data
newLine: .asciiz "new line\n"
array: .word 4,5,2,2,1,6,7,9,5,10
//antal: word 10


.text
.set noreorder
.globl skriv			
.ent skriv

skriv:
subu sp,sp,24			//flyttar stackpekaren
sw ra,20(sp)       //sparar returadresssen

li t0,20
L1:
ble t0,10,L2
la a0, newLine  //lägger till adressen till newLine i a0
jal printf		
nop
addi t0,t0,-1;
b L1
nop

L2:
lw ra,20(sp) // laddar in returadressen
addiu sp,sp,24 //flyttar tillbaka stackpekaren
jr ra
nop
.end skriv


.globl start
.ent start

start:

subu sp,sp,24
sw ra,20(sp)

jal skriv		//kör subrutinen skriv
nop

lw ra,20(sp) //laddar in returadressen
addiu sp,sp,24 //flyttar stackpekaren
jr ra
nop
.end start
