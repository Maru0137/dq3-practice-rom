; === An encount step status window hacked the coordinate window ===
;
; We can display this window by entering R button when coodinate window is enabled.
; They will be displayed as follows:
; 
; ┌---------------------------------┐
; |MX: <mx>                         |
; |MY: <my>                         |
; |WX: <encount_step_remain>        |
; |WY: <encount_table_id>           |
; |ML: <encount_step_decrement_base>|
; |                         00000000|
; └---------------------------------┘
;

!encount_step_remain_offset = $f796
!get_encount_table_and_decrement_step_base = $c690a1  ; A = encount_table_id, X = encount_step_decrement_base, Y = ???

; $c35bc5: SR to describe coordinate window 
;; MX
org $c38bd3
JSL draw_mx

;; MY
org $c38bf0
JSL draw_my

;; encount step remain
org $c38c06
JSL draw_encount_step_remain

;; encount table
org $c38c1c
JSL draw_encount_table_id

;; encount step decrement base
org $c38c32
LDX #$0002   ; set number of whitespace
org $c38c39
JSL draw_encount_step_decrement_base
org $c38c3d
LDX #$0003   ; set number of digit

;; last (dummy)
org $c38c48
JSL draw_dummy


; $c35079: SRs to describe values into window
org $c35079

;; MX
draw_mx:
    LDA $c361
    JMP $4eeb

;; MY
draw_my:
    LDA $c363
    JMP $4eeb

;; encount step remain
draw_encount_step_remain:
    LDA !encount_step_remain_offset
    JMP $4eeb

;; encount table id
draw_encount_table_id:
    PHY
    JSL !get_encount_table_and_decrement_step_base
    PLY
    JMP $4eeb

;; encount step decrement base
draw_encount_step_decrement_base:
    PHY
    JSL !get_encount_table_and_decrement_step_base
    PLY
    TXA
    JMP $4eeb

;; last (dummy)
draw_dummy:
    LDA #$0000


; Prefix strings
org $c3ab30
db $95, $9e, $93  ; "ENC"

org $c3ab35
db $a4, $92, $ac  ; "TBL"

org $c3ab3a
db $94, $95, $93  ; "DEC"
