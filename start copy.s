.eqv button_base 0xffff0020
.eqv led_base 0xffff0010

.text


    csrci ustatus, 1
    la t0, exception_handler        
    csrw t0, utvec
    csrsi ustatus, 1

loop:
    add t0, zero, zero
    add t1, zero, zero
    j loop

.align 2 
exception_handler:
    csrr t0, ucause
    li t1,0x80000008
    beq t1,t0,ext_interrupt
    j exception_done

ext_interrupt:
    li t0,button_base
    lw t1,0(t0)
    li t0,led_base
    sw t1,0(t0)
    uret

exception_done:
    csrr t0, uepc
    addi t0, t0, 4
    csrw t0, uepc
    uret