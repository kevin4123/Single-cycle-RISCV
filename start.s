.data
hello: .asciiz "hello world\n"
.align 2
stack_end:
    .space 1024
stack_start:

.text
.eqv led_base 0xffff0010
.eqv timer_base 0xffff0000
.eqv button_base 0xffff0020
.eqv disp_base 0xffff8000
.eqv count a3
.eqv color a4
.eqv term_base 0xffff0030

start:
    # …Ë÷√’ª
    la sp,stack_start
    # ¥Ú”°hello
    la a0,hello
    call puts


loop:
    call getc
    beq a0,x0,loop

    addi a0,a0,1
    call putc

    li a0,'\n'
    call putc

    j loop

putc:
    li a1,term_base
    sb a0,0(a1)
    ret


getc:
    li a1,term_base
    lb a0,0(a1)
    ret


puts:
    addi sp,sp,-4
    sw ra,0(sp)
    
    mv a2,a0

puts_loop:   
    lb a0,0(a2)
    beq a0,x0,puts_done
    call putc
    addi a2,a2,1
    j puts_loop

puts_done:

    lw ra,0(sp)
    addi sp,sp,4
    ret



# —” ±
delay:
    beq a0,x0,delay_done
    addi a0,a0,-1
    j delay
delay_done:
    ret

