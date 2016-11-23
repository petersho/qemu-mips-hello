#ifndef __UART_H__
#define __UART_H__

//Define
#define UART0_BASE 0xB40003F8	/* 16550 COM1 */

// API
void init_serial(void);
void print_uart0(const char *s);

#endif
