#include "hello/hello.h"
#include "A_shares/A_shares.h"

#define INSTALL_MODULARS \
	if (!strcmp("A_shares",argv[1])) return (modular_A_shares(argc, argv));\
	if (!strcmp("hello",argv[1])) return (modular_hello(argc, argv));
