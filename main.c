#include <bsp.h>
#include <uart.h>

int main()
{
	init_serial();
	print_uart0("Hello world!\n");

	// Never return
	while(1);

	return 0;
}

