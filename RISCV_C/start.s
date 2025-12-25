.data
.align 12
stack_end:
    .skip 1024
stack:                # top of the stack

.text
.globl _start
_start:

    csrci ustatus, 1 # disable interrupt
    
    la sp, stack

    call main        
    
    j .
