#ifndef __BSP_H__
#define __BSP_H__

#include <mipsregs.h>

#define readb(reg)		(*((volatile unsigned char *) (reg)))
#define readw(reg)		(*((volatile unsigned short *) (reg)))
#define readl(reg)		(*((volatile unsigned int *) (reg)))

#define writeb(data, reg)	((*((volatile unsigned char *)(reg))) = (unsigned char)(data))
#define writew(data, reg)	((*((volatile unsigned short *)(reg))) = (unsigned short)(data))
#define writel(data, reg)	((*((volatile unsigned int *)(reg))) = (unsigned int)(data))

#endif
