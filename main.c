#define UART0_BASE 0xB40003F8  /* 16550 COM1 */

void init_serial() {
	volatile char * addr;
	addr = (volatile char*)(UART0_BASE + 2);
	*addr = 0xc1;
	addr = (volatile char*)(UART0_BASE + 3);
	*addr = 0x03;
	addr = (volatile char*)(UART0_BASE + 4);
	*addr = 0x03;
	addr = (volatile char*)(UART0_BASE + 5);
	*addr = 0x60;
	addr = (volatile char*)(UART0_BASE + 6);
	*addr = 0xb0;
	addr = (volatile char*)(UART0_BASE + 7);
	*addr = 0x00;
}

int is_transmit_empty()
{
 	volatile char *addr = (volatile char *)(UART0_BASE + 5);

	return *addr & 0x20;
}

void write_serial(char a)
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

int main()
{
	init_serial();
	print_uart0("Hello world!\n");

	// Never return
	while(1);

	return 0;
}

