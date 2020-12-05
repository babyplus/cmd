#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include "common_macro.h"
#include "modulars.h"

void usage()
{
	printf("usage:\n    ...\n");
}

int main( int argc, char** argv ) 
{
	if (argc<2) 
	{	usage();
		return 1;
	}

	TARGET("selected modular: %s", argv[1])
	INSTALL_MODULARS
        else 
	{
		PUTS_RED("unsupported");
		return 2;
	}
}

