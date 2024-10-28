; Programming Project 1 starter file
; Student Name: Srinithi Arumugam
; UTEid: sa59523
; Modify this code to satisfy the requirements of Program 1
; Compute N^M, where N and M are non-negative inputs to your program.
; The input numbers are given to you in memory locations x3100 (N) and x3101 (M) 
; The computed result has to be placed in x3102 (N2theM). 
; If the computation of the value of NM exceeds x7FFF then you put the 
; value -1 at x3102. Assume 0^0 = 0.
; Read the complete Project Description on the Google doc linked


;Outer loop M times
;Then inner loop N times and add to N each time
;To produce N*N

    .ORIG  x3000
; Your solution goes here

AND R1, R1, #0 ; N
AND R2, R2, #0 ; M
AND R3, R3, #0 ; N^M
AND R4, R4, #0 ; overflow
AND R5, R5, #0 ; branching and register logic
AND R6, R6, #0 ; multiplication
AND R7, R7, #0 ; loop counter

; load
LD R1, N          ; load n to r1
LD R2, M          ; loading n to r2

ADD R5, R5, R1
BRZ ZERO_CASE     ; If N is zero, branch to ZERO_CASE (N^M = 0)

AND R5, R5, #0    ; Clear R5 
ADD R5, R5, R2    ; Copy M into R5
BRZ EXPONENT_ZERO ; If M is zero, branch to EXPONENT_ZERO (N^M = 1)

; exponent one
ADD R6, R6, R1
ADD R2, R2, #-1
BRZ EXPONENT_ONE  


;ADD R5, R5, R0
;BRZ ZERO_CASE     ; If N is zero, branch to ZERO_CASE (N^M = 0)

;AND R5, R5, #0    ; Clear R5 
;ADD R5, R5, R2    ; Copy M into R5
;BRZ EXPONENT_ZERO ; If M is zero, branch to EXPONENT_ZERO (N^M = 1)

; loop one
LOOP_ONE:
    ADD R7, R7, R1  
; loop two
LOOP_TWO:
    ADD R3, R3, R6  ; Add R6 to R3
    ADD R7, R7, #-1 ; Decrease loop 2 counter
    BRP LOOP_TWO  ; repeat if not work..
    ADD R6, R6, R3 


;---- Overflow Check ----
    NOT R4, R3      ; Take 2's complement
    ADD R4, R4, #1 
    ADD R4, R4, R6 ; overflow check
    BRN OVERFLOW_CASE ; Branch if overflow is detected

    AND R6, R6, #0  ; clearing R6
    ADD R6, R6, R3  
    AND R4, R4, #0
    AND R3, R3, #0  ; 

    ADD R2, R2, #-1 ; Decrease M (outer loop counter)
    BRP LOOP_ONE  ; Repeat loop 1 if M > 0
;---- Store Final Result ----
    ST R6, N2theM   ; Store final result in memory (N^M)
    BR DONE

    
;Special Cases 

EXPONENT_ONE:
    ;BR DONE
    ST R1, N2theM   ; Store N if M = 1
    BR DONE

ZERO_CASE:
    ;BR DONE 
    AND R5, R5, #0  ; Set result to 0 if N = 0
    ST R5, N2theM   ; Store N^M = 0 in memory
    BR DONE
    
EXPONENT_ZERO:
    ;BR DONE
    AND R5, R5, #0  
    ADD R5, R5, #1 
    ST R5, N2theM   ; Store result in memory
    BR DONE


OVERFLOW_CASE:
    ;BR DONE
    AND R5, R5, #0  ; clear R5
    ADD R5, R5, #-1 
    ST R5, N2theM   ; Store overflow result in memory
    BR DONE
    
          DONE HALT
    .END
    

;---- Data: Inputs and Output go here
    .ORIG x3100
;N    .FILL x0003
;M    .FILL x0002
N    .FILL x7FFF
M    .FILL x0001
;N    .FILL x0002
;M    .FILL x000A
;N    .FILL x00B2
;M    .FILL x0002
;N    .FILL x0005
;M    .FILL x0000
N2theM  .BLKW #1
    .END
