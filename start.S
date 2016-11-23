    .text
    .globl _start
_start:
    lui     $sp, %hi(stack_top)
    addiu   $sp, $sp, %lo(stack_top)
    lui     $t9, %hi(main)
    addiu   $t9, %lo(main)
    jalr    $t9
    nop
hang:
	b       hang
