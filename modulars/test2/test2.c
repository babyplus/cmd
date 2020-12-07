#include "test2.h"

int main(int argc, char** argv)
{
    return _main(argc, argv);
}

int modular_test2(int argc, char** argv)
{
    int _argc = argc-1;
    char* _argv[_argc];
    int i = 0;
    for (i;i<_argc;i++) _argv[i] = argv[i+1];
    _main(_argc, _argv);
}

static int _main(int argc, char** argv)
{
    printf("modular: %s argc: %d; first arg: %s\n", argv[0], argc, argv[1]);	
}

