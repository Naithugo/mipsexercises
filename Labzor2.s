#include <iregdef.h>


.data
newLine: .asciiz "new line\n"


.text
.set noreorder
.globl skriv			
.ent skriv

skriv:
  subu sp,sp,24			//flyttar stackpekaren
  sw ra,20(sp)       //sparar returadresssen

  la a0, newLine  //lägger till adressen till newLine i a0
  jal printf		
  nop

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
