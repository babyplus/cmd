#include "hello/hello.h"

#define INSTALL_MODULARS \
	if (!strcmp("hello",argv[1])) return (modular_hello(argc, argv));\
        else\
	{\
		PUTS_RED("unsupported");\
		return 2;\
	}
