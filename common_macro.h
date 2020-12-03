#ifndef COMMON_MACRO
#define COMMON_MACRO
#define DEVELOPING
#define MOCK_MODE

#ifdef DEVELOPING

#define PRINT_RED(str)      printf("\033[0;31m%s\033[0;39m", str);
#define PRINT_GREEN(str)    printf("\033[0;32m%s\033[0;39m", str);
#define PRINT_YELLOW(str)   printf("\033[0;33m%s\033[0;39m", str);
#define PRINT_BULE(str)     printf("\033[0;34m%s\033[0;39m", str);
#define PRINT_PURPLE(str)   printf("\033[0;35m%s\033[0;39m", str);

#define PUTS_RED(str)       printf("\033[0;31m%s\n\033[0;39m", str);
#define PUTS_GREEN(str)     printf("\033[0;32m%s\n\033[0;39m", str);
#define PUTS_YELLOW(str)    printf("\033[0;33m%s\n\033[0;39m", str);
#define PUTS_BULE(str)      printf("\033[0;34m%s\n\033[0;39m", str);
#define PUTS_PURPLE(str)    printf("\033[0;35m%s\n\033[0;39m", str);

#define DEBUGING(info,...) do { \
	if (g_debug_mode) { \
		printf("\033[1;44m");\
		printf(info, ##__VA_ARGS__);\
		printf("\033[1;49m\n"); \
	} \
} while (0);
#define TARGET(info,...) do { \
	if (g_debug_mode) { \
		printf("\033[0;35mnext step :");\
		printf(info, ##__VA_ARGS__);\
		printf("\033[0;39m\n"); \
	} \
} while (0);
#define DEBUG(info,...) do { \
	if (g_debug_mode) { \
		printf("\033[0;34m");\
		printf(info, ##__VA_ARGS__);\
		printf("\033[0;39m"); \
	} \
} while (0);
#define SIMPLE_DEBUG(info,...) do { \
	if (g_debug_mode) {\
		printf("\033[0;33m");\
		printf(info, ##__VA_ARGS__);\
		printf("\033[0;39m"); \
	}\
} while (0);
static char g_debug_mode = 1;
#else
#define TARGET(info,...) do { \
	if (g_debug_mode) {\
		printf("...\n");\
		printf("<NEXT STEP>:");\
		printf(info, ##__VA_ARGS__);\
		printf("\n");\
	}\
} while (0);
#define DEBUGING(info,...) do {\
	 if (g_debug_mode) {\
		printf(info, ##__VA_ARGS__); \
	}\
} while (0);
#define DEBUG(info,...) do { if (g_debug_mode) printf("<DEBUG>: %s ( %s ) [%d]: "info, __FILE__, __func__, __LINE__, ##__VA_ARGS__); } while (0);
#define SIMPLE_DEBUG(info,...) do { if (g_debug_mode) printf(info, ##__VA_ARGS__); } while (0);

static char g_debug_mode = 0;
#endif

#ifdef MOCK_MODE
#define MOCK(test) test
#else
#define MOCK(test) /\
/\

#endif
#endif //COMMON_MACRO
