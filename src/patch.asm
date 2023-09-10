;====================
; DQ3 Practice rom
; By Maru0137
;===================


hirom

!ROM_BASE = $c00000
!WRAM_BASE = $7e0000

; Game title
org !ROM_BASE+$ffc0
db "DRAGONQUEST3PRACTICE "

incsrc "debug.asm"
incsrc "encount_step.asm"
