#include "hello.h"

void printhello()
{
	puts("Hello World!");
}
int modular_hello(int argc, char** argv)
{
	DEBUG("argc: %d; program: %s; modular: %s;\n", argc, argv[0], argv[1]);

	TARGET("parse arguments")
	int ch;
	while ((ch = getopt(argc, argv, "dv:")) != -1) 
	{
		switch(ch) 
		{
			case 'd':
				DEBUG("opt is d, oprarg is: %s\n", optarg)
				g_debug_mode = 1;
				break;
			case 'v':
				DEBUG("opt is v, oprarg is: %s\n", optarg)
				PUTS_YELLOW(optarg)
				break;
			case '?':
				printhello();
				exit(0);
		}
	}	
	return 0;
}

