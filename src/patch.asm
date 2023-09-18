;====================
; DQ3 Practice rom
; By Maru0137
;===================


hirom

!rom_base = $c00000
!wram_base = $7e0000

; Game title
org !rom_base+$ffc0
db "DRAGONQUEST3PRACTICE "

incsrc "define_window.asm"

incsrc "debug.asm"
incsrc "encount_step.asm"
