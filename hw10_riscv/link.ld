SECTIONS
{
    . = 0x00000000;
    .text : { *(.text) }
    .rodata : { *(.rodata .rodata.*) }
    .data : { *(.data) }
    .bss : { *(.bss) }
}
