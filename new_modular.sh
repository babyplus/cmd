modular_name=${1:-hello}
modulars_dir=${2:-modulars}
modulars_head_file=modulars.h
modular_dir=$modulars_dir/$modular_name
modular_head_file=$modular_dir/$modular_name.h
modular_cpp_file=$modular_dir/$modular_name.c
modular_func=modular_$modular_name

mkdir -p $modular_dir

cat > $modular_head_file << EOF
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include "../../common_macro.h"

int $modular_func(int argc, char** argv);

EOF

cat > $modular_cpp_file << EOF
#include "$modular_name.h"

int $modular_func(int argc, char** argv)
{
    printf("argc: %d; program: %s; modular: %s;\n", argc, argv[0], argv[1]);
}

EOF

> $modulars_head_file

ls $modulars_dir  |awk -v modulars_head_file=$modulars_head_file '{print("echo '\''#include \""$1"/"$1".h\"'\''>> "modulars_head_file);}'|bash 

cat >> $modulars_head_file << EOF

#define INSTALL_MODULARS \\
EOF

ls $modulars_dir |awk -v modulars_head_file=$modulars_head_file '{print("echo '\''	if (!strcmp(\""$1"\",argv[1])) return (modular_"$1"(argc, argv));\\'\'' >> "modulars_head_file)}'|bash 

cat >> $modulars_head_file << EOF
        else\\
	{\\
		PUTS_RED("unsupported");\\
		return 2;\\
	}
EOF

ls $modulars_dir | awk -v modulars_dir=$modulars_dir '{print("gcc "modulars_dir"/"$1"/"$1".c -fPIC -shared -o lib"toupper(substr($1,1,1))substr($1, 2)".so")}'

echo 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:`pwd`'

echo -n 'gcc main.c '
ls $modulars_dir |awk '{print("echo -n '\''-l"toupper(substr($1,1,1))substr($1, 2))" '\''"}' |bash
echo ' -L. -I modulars/'

echo "./a.out $modular_name 1 2 3 4 5"
