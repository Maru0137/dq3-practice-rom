!ENCOUNT_STEP_OFFSET = $f796

; Display encount step in coodinate window
org $c35079
lda !ENCOUNT_STEP_OFFSET

org $c3ab30
db $95, $9e, $93  ; "ENC"
