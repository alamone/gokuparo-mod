; Gokujou Parodius JP ver mod - skip to selected stage

; "stage" should be set to desired stage
; 0000 = stage 1 (claw machine)
; 0001 = stage 2 (cat pirate)
; 0002 = stage 3 (sweets)
; 0003 = stage 4 (high speed)
; 0004 = stage 5 (space)
; 0005 = stage 8 (party)
; 0006 = stage 7 (moon)
; 0007 = stage 6 (moai)
; 0008 = special stage

; constants
base_address = $200000
free_space = $F9DD0
;stage_var = $C0D916
;hi_score  = $C0D736
;1p_score  = $C0D73A
;rank      = $C0d922  2F is max
;timerank  = $C0D7CC  14 is default, 1F is max

; patch address locations
romram_check = $9D4AE
stage_init   = $A9496
stage_init_2 = $A949E
timerank_init   = $AB93A
timerank_init_2 = $AB9AE
 
 org 0
  incbin  "321jad.bin"

; always pass ROM/RAM check
 org romram_check
  nop
  nop
 
 org stage_init
  jmp free_space+base_address

 org timerank_init
  move.w  #$1F, (A1) ; set timerrank from 14 -> 1F (max)
  
 org timerank_init_2
  move.w  #$1F, (A2) ; set timerrank from 14 -> 1F (max)
  
 org free_space + base_address

stage_select: 
  move.w  #stage, (A1,D0.l) ; set the stage to "stage"  
  clr.w   ($518,A1)
  jmp stage_init_2+base_address
