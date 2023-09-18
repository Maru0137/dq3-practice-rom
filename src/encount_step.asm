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

!RAM_ENCOUNT_STEP_OFFSET = $f796
!SR_GET_ENCOUNT_TABLE_AND_DECREMENT_STEP_BASE = $c690a1  ; A = encount_table_id, X = encount_step_decrement_base, Y = ???

; $c35bc5: SR to describe coordinate window 
;; MX
org $c38bd3
jsl $c35079

;; MY
org $c38bf0
jsl $c3507f

;; encount step remain
org $c38c06
jsl $c35085

;; encount table
org $c38c1c
jsl $c3508b

;; encount step decrement base
org $c38c32
ldx #$0002   ; set number of whitespace
org $c38c39
jsl $c35094
org $c38c3d
ldx #$0003   ; set number of digit

;; last (dummy)
org $c38c48
jsl $c3509e


; $c35079: SRs to describe values into window
org $c35079

;; MX
lda $c361
jmp $4eeb

;; MY
lda $c363
jmp $4eeb

;; encount step remain
lda !RAM_ENCOUNT_STEP_OFFSET
jmp $4eeb

;; encount table id
phy
jsl !SR_GET_ENCOUNT_TABLE_AND_DECREMENT_STEP_BASE
ply
jmp $4eeb

;; encount step decrement base
phy
jsl !SR_GET_ENCOUNT_TABLE_AND_DECREMENT_STEP_BASE
ply
txa
jmp $4eeb

;; last (dummy)
lda #$0000


; Prefix strings
org $c3ab30
db $95, $9e, $93  ; "ENC"

org $c3ab35
db $a4, $92, $ac  ; "TBL"

org $c3ab3a
db $94, $95, $93  ; "DEC"
