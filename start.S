    .text
    .globl _start
_start:
	b		reset
	nop

	.org 0x180
	/* General exception */
1:	b	1b
	nop

	.align 4

reset:
	/* Clear CP0_SR:BEV to 0 */
	mfc0	$t0, $12
	and		$t0, 0xffbfffff
	mtc0	$t0, $12

	/* Setup stack address */
    lui     $sp, %hi(stack_top)
    addiu   $sp, $sp, %lo(stack_top)
    lui     $t9, %hi(main)
    addiu   $t9, %lo(main)
    jalr    $t9
    nop
hang:
	b       hang
