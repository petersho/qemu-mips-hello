#include <bsp.h>
#include <uart.h>

static int is_transmit_empty()
{
 	volatile char *addr = (volatile char *)(UART0_BASE + 5);

	return *addr & 0x20;
}

static void write_serial(char a)
{
	volatile char *addr = (volatile char*)UART0_BASE;

	while (is_transmit_empty() == 0);
	*addr = a;
}

void print_uart0(const char *s)
{
	while(*s != '\0') { /* Loop until end of string */
		write_serial( *s );
		s++; /* Next char */
	}
}

void init_serial()
{
	writeb(0xc1, UART0_BASE + 2);
	writeb(0x03, UART0_BASE + 3);
	writeb(0x03, UART0_BASE + 4);
	writeb(0x60, UART0_BASE + 5);
	writeb(0xb0, UART0_BASE + 6);
	writeb(0x00, UART0_BASE + 7);
}

