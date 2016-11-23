#ifndef __MIPSREGS_H__
#define __MIPSREGS_H__

/*
 * Macros to access the system control coprocessor
 */
#define __read_32bit_c0_register(source, sel)				\
({ unsigned int __res;							\
	if (sel == 0)							\
		__asm__ __volatile__(					\
			"mfc0\t%0, " #source "\n\t"			\
			: "=r" (__res));				\
	else								\
		__asm__ __volatile__(					\
			".set\tmips32\n\t"				\
			"mfc0\t%0, " #source ", " #sel "\n\t"		\
			".set\tmips0\n\t"				\
			: "=r" (__res));				\
	__res;								\
})

#define __write_32bit_c0_register(register, sel, value)			\
do {									\
	if (sel == 0)							\
		__asm__ __volatile__(					\
			"mtc0\t%z0, " #register "\n\t"			\
			: : "Jr" ((unsigned int)(value)));		\
	else								\
		__asm__ __volatile__(					\
			".set\tmips32\n\t"				\
			"mtc0\t%z0, " #register ", " #sel "\n\t"	\
			".set\tmips0"					\
			: : "Jr" ((unsigned int)(value)));		\
} while (0)

#define __readx_32bit_c0_register(source)				\
({									\
	unsigned int __res;						\
									\
	__asm__ __volatile__(						\
	"	.set	push					\n"	\
	"	.set	noat					\n"	\
	"	.set	mips32r2				\n"	\
	"	.insn						\n"	\
	"	# mfhc0 $1, %1					\n"	\
	"	.word	(0x40410000 | ((%1 & 0x1f) << 11))	\n"	\
	"	move	%0, $1					\n"	\
	"	.set	pop					\n"	\
	: "=r" (__res)							\
	: "i" (source));						\
	__res;								\
})

#define readx_c0_entrylo0()	__readx_32bit_c0_register(2)
#define read_c0_count()		__read_32bit_c0_register($9, 0)

#endif
