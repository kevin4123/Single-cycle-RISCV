OUTPUT_ARCH(riscv)

ENTRY(_start)           /* 入口 */

SECTIONS {
    
    . = 0x00400000;     /* .text 起始地址 */

    .text : {
        *(.text)
        *(.text.*)
    }

    . = 0x10010000;     /* .data 起始地址 */

    .data : {
        *(.data)
        *(.data.*)
        *(.rodata)
        *(.rodata.*)    
    }

    .bss : {
        _bss_start = .;
        *(.bss)
        *(.bss.*)
        *(COMMON)
        _bss_end = .;
    }
}
