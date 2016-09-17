#include <iregdef.h>
.data
word: 
.asciiz "Hello world\n"
word2: 
.asciiz "Christina is mass effect master everyday\n"

.text
.set noreorder
.global start
.ent start
start:
	subu sp,sp,24 //// allokerar 24 ord till subrutin ?? 
	sw ra,20(sp) //
	
	la a0,word //lägger till adressen till word i a0
	jal printf
	nop			//fyller med nollor
	
	la a0,word2 
	jal printf
	nop	
	
	lw ra,20(sp)
	addiu sp,sp,24
	jr ra
.end start

