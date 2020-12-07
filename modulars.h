#include "hello/hello.h"
#include "test2/test2.h"

#define INSTALL_MODULARS \
	if (!strcmp("hello",argv[1])) return (modular_hello(argc, argv));\
	if (!strcmp("test2",argv[1])) return (modular_test2(argc, argv));\
        else\
	{\
		PUTS_RED("unsupported");\
		return 2;\
	}
