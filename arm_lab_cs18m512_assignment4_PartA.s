/******************************************************************************
* file: arm_lab_cs18m512_assignment4.s
* author: Premkumar Sholapur
* Roll no: cs18m512
* Guide: Prof. Madhumutyam IITM, PACE
******************************************************************************/

/*
 *Character-Coded Data, Part-1: String compare
 */

  @ BSS section
      .bss

  @ DATA SECTION
      .data
Length:        .byte 0x03

String1:       .byte 0x43 @'C'
               .byte 0x41 @'A'
               .byte 0x54 @'T'
               
String2_TestA: .byte 0x42 @'B'
               .byte 0x41 @'A'
               .byte 0x54 @'T'
               
String2_TestB: .byte 0x43 @'C'
               .byte 0x41 @'A'
               .byte 0x54 @'T'
               
String2_TestC: .byte 0x43 @'C'
               .byte 0x55 @'U'
               .byte 0x54 @'T'

               .byte 0x0 @ padding
               .byte 0x0 @ padding
               .byte 0x0 @ padding
               
Output_TestA:  .word 0x0 @ word aligned after padding
Output_TestB:  .word 0x0
Output_TestC:  .word 0x0

  @ TEXT section
      .text

.globl _main

_main:
      LDR  R0, =Length
      LDRB R0, [R0]
      LDR  R1, =String1
      LDR  R2, =String2_TestA
      LDR  R3, =Output_TestA
      
      BL FUNC_SUBSTR

      LDR  R0, =Length
      LDRB R0, [R0]
      LDR  R1, =String1
      LDR  R2, =String2_TestB
      LDR  R3, =Output_TestB
      
      BL FUNC_SUBSTR

      LDR  R0, =Length
      LDRB R0, [R0]
      LDR  R1, =String1
      LDR  R2, =String2_TestC
      LDR  R3, =Output_TestC
      
      BL FUNC_SUBSTR
      B DONE_PROGRAM

@ Inputs: R0 - length, R1 - String1, R2 - String2 to search, 
@ Output: R3 (0x0 greater than or equal, 0xFFFFFFFF less than)

FUNC_SUBSTR:
      LDRB R4, [R1], #1
      LDRB R5, [R2], #1
      CMP R4, R5
      BLT DONE_LT
      SUBS R0, R0, #1
      BNE FUNC_SUBSTR
      B DONE_EQGT

DONE_LT:
      MOV R4, #0xFFFFFFFF
      STR R4, [R3] 

DONE_EQGT:
      BX LR
      
DONE_PROGRAM:
      NOP
