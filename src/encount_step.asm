; === An encount step status window hacked the coordinate window ===
;
; We can display this window by entering R button when coodinate window is enabled.
; They will be displayed as follows:
; 
; ┌-------------------------------------┐
; |MX:                             <mx> |
; |MY:                             <my> |
; |TX:                         <tile_y> |
; |TY:                         <tile_x> |
; |TBL:              <encount_table_id> |
; |BASE:  <encount_step_decrement_base> |
; |RATE: <encount_step_decrement_ratio> |
; |DEC:        <encount_step_decrement> |
; |               <encount_step_remain> |
; └-------------------------------------┘
;

!encount_step_remain_offset = $f796
get_encount_table_and_decrement_step_base = $c690a1  ; A = encount_table_id, X = encount_step_decrement_base, Y = ???
get_struct_member = $c903ee

!coord_window_id = $7c
!coord_window_entry_base = window_table_entry_base(!coord_window_id)

; Change the coord window size
;   CX: 19 (0b10011)
;   CY: 8  (0b01000)
;   SX: 12 (0b01100)
;   SY: 19 (0b10011)
org !coord_window_entry_base
db $13, $b1, $59

; Change the coord window 
org !coord_window_entry_base+!window_table_describe_address_offset
;org #c305d9
dw $f30a

org !extended_window_sr_base
describe_encount_step_window:
.mx
    LDA #$ab25
    JSL $c32b21
    LDX #$0004
    JSL $c32b70
    JSL $c35085
    LDX #$0003
    JSL $c32c9e
    JSL $c35500
.my
    LDA #$ab2a
    JSL $c32b21
    LDX #$0004
    JSL $c32b70
    JSL $c3508b
    LDX #$0003
    JSL $c32c9e
    JSL $c35500
.tile_x
    LDA #$f500  ; "TX:"
    JSL $c32b21
    LDX #$0005
    JSL $c32b70
    JSL $c35085  ; TODO: change address
    LDX #$0002
    JSL $c32c9e
    JSL $c35500
.tile_y
    LDA #$f505  ; "TY:"
    JSL $c32b21
    LDX #$0005
    JSL $c32b70
    JSL $c35085  ; TODO: change address
    LDX #$0002
    JSL $c32c9e
    JSL $c35500
.encount_table_id
    LDA #$f50a  ; "TBL:"
    JSL $c32b21
    LDX #$0003
    JSL $c32b70
    JSL draw_encount_table_id
    LDX #$0003
    JSL $c32c9e
    JSL $c35500
.encount_step_decrement_base
    LDA #$f510  ; "BASE:"
    JSL $c32b21
    LDX #$0002
    JSL $c32b70
    JSL draw_encount_step_decrement_base
    LDX #$0003
    JSL $c32c9e
    JSL $c35500
.encount_step_decrement_ratio
    LDA #$f517  ; "RATE:"
    JSL $c32b21 
    LDX #$0004
    JSL $c32b70
    JSL draw_encount_step_decrement_ratio
    LDX #$0001
    JSL $c32c9e
    JSL $c35500
.encount_step_decrement
    LDA #$f51e  ; "DEC:"
    JSL $c32b21
    LDX #$0001
    JSL $c32b70
    JSL draw_encount_step_decrement
    LDX #$0005
    JSL $c32c9e
    JSL $c35500
.encount_step_remain
    LDX #$0005
    JSL $c32b70
    JSL draw_encount_step_remain
    LDX #$0005
    JSL $c32c9e
    JSL $c35500
    RTL

draw_encount_table_id:
    PHY
    JSL get_encount_table_and_decrement_step_base
    PLY
    JMP $4eeb

draw_encount_step_decrement_base:
    PHY
    JSL get_encount_table_and_decrement_step_base
    PLY
    TXA
    JMP $4eeb

draw_encount_step_decrement_ratio:
    PHY
    JSL get_encount_table_and_decrement_step_base
    TAX
    JSL get_struct_member
    db $01
    dw $0014
    dl $c8b605
    dw $0000
    PLY
    JMP $4eeb

draw_encount_step_decrement:
    PHY
    JSL get_encount_table_and_decrement_step_base
    ;STA $1a
    STZ $02
    STX $00
    TAX
    JSL get_struct_member
    db $01
    dw $0014
    dl $c8b605
    dw $0000
    ASL
    TAX
    LDA $c6902f, X
    LDX #$0000
    JSL $c010d6
    ASL $00
    ROL $02
    ASL $00
    ROL $02
    LDA $1
    PLY
    JMP $4eeb

draw_encount_step_remain:
    LDA !encount_step_remain_offset
    JMP $4eeb

org $c3f500
db $00, $a4, $a8, $05, $00            ; "TX:"
db $01, $a4, $a9, $05, $00            ; "TY:"
db $02, $a4, $92, $ac, $05, $00       ; "TBL:"
db $03, $92, $91, $a3, $95, $05, $00  ; "BASE:"
db $04, $a2, $91, $a4, $95, $05, $00  ; "RATE:"
db $05, $94, $95, $93, $05, $00       ; "DEC:"
