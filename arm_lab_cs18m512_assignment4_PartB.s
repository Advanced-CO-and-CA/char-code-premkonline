/******************************************************************************
* file: arm_lab_cs18m512_assignment4.s
* author: Premkumar Sholapur
* Roll no: cs18m512
* Guide: Prof. Madhumutyam IITM, PACE
******************************************************************************/

/*
 *Character-Coded Data, Part-2: Find sub-string
 */

  @ BSS section
      .bss

  @ DATA SECTION
      .data

String1:
               .byte 0x43 @'C'
               .byte 0x53 @'S'
               .byte 0x36 @'6'
               .byte 0x36 @'6'
               .byte 0x32 @'2'
               .byte 0x30 @'0'
               .byte 0x0

String2_TestA: 
               .byte 0x53 @'S'
               .byte 0x53 @'S'
               .byte 0x0

String2_TestB:
               .byte 0x36 @'6'
               .byte 0x32 @'2'
               .byte 0x30 @'0'
               .byte 0x0

String2_TestC:
               .byte 0x36 @'6'
               .byte 0x36 @'6'
               .byte 0x0

               .byte 0x0 @ padding
               .byte 0x0 @ padding
               .byte 0x0 @ padding

Present_TestA: .word 0x0
Present_TestB: .word 0x0
Present_TestC: .word 0x0


  @ TEXT section
      .text


.globl _main

_main:
      LDR  R0, =String1
      LDR  R1, =String2_TestA
      LDR  R2, =Present_TestA
      
      BL FUNC_SUBSTR

      LDR  R0, =String1
      LDR  R1, =String2_TestB
      LDR  R2, =Present_TestB
      
      BL FUNC_SUBSTR

      LDR  R0, =String1
      LDR  R1, =String2_TestC
      LDR  R2, =Present_TestC
      
      BL FUNC_SUBSTR
      
      BL DONE_PROGRAM
      
@ Inputs: R0 - String1, R1 - String2 to search, 
@ Output: R2 (0x0 if not present, index if present)

FUNC_SUBSTR:
      MOV R4, R0 @ Store String1 address
      MOV R5, R1 @ Store String2 address
      MOV R6, #0 @ found index in string1
      
LOOP:
      LDRB R7, [R0], #1
      LDRB R8, [R1], #1
      CMP R7, #0
      BEQ LOOP_END
      CMP R8, #0
      BEQ LOOP_END
      
      CMP R7, R8
      BEQ EQ_CHAR

      CMP R6, #0
      ADDNE R0, R4, R6 @ Reset index to last failed match for String1
      MOV R6, #0
      MOV R1, R5       @ Restart index=0 for String2
      B LOOP

EQ_CHAR:
      CMP R6, #0       @ if not zero, match already found, index stored 
      SUBEQ R6, R0, R4 @ Save index if zero
      B LOOP
      
LOOP_END:
      STR R6, [R2]
      BX LR
      
DONE_PROGRAM:
      NOP