#include <bsp.h>
#include <uart.h>

int main()
{
	unsigned int tt = 0;
	int i = 0;

	init_serial();
	print_uart0("Hello world!\n");

	for (i = 0 ; i < 10 ; i++) {
		tt = read_c0_count();
	}
	// Never return
	while(1);

	return 0;
}

