root_dir=`pwd`
ld_dir="$root_dir/libs"
main_c_file=$root_dir/main.c
modular_name=${1:-hello}
modulars_dir=${2:-$root_dir/modulars}
modulars_head_file=$root_dir/modulars.h
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
static int _main(int argc, char** argv);
EOF

cat > $modular_cpp_file << EOF
#include "$modular_name.h"

int main(int argc, char** argv)
{
    return _main(argc, argv);
}

int $modular_func(int argc, char** argv)
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

ls $modulars_dir | awk -v modulars_dir=$modulars_dir -v ld_dir=$ld_dir '{print("gcc "modulars_dir"/"$1"/"$1".c -fPIC -shared -o "ld_dir"/lib"toupper(substr($1,1,1))substr($1, 2)".so")}'

echo "export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$ld_dir"

echo -n "gcc $main_c_file "
ls $modulars_dir |awk '{print("echo -n '\''-l"toupper(substr($1,1,1))substr($1, 2))" '\''"}' |bash
echo " -L $ld_dir -I $modulars_dir"

echo "./a.out $modular_name 1 2 3 4 5"
