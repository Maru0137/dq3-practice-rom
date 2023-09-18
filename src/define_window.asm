!window_table_base = !rom_base+$30000
!window_table_entry_size = $c

function window_table_entry_base(id) = !window_table_base+(id*!window_table_entry_size)

!window_table_describe_address_offset = $9  ; 16-bit

!extended_window_sr_base = !rom_base+$3f30a
