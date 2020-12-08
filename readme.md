来获知自己电脑上的include默认搜索路径  

```
`gcc -print-prog-name=cc1` -v
```

获知库默认搜索路径  

```
gcc -print-search-dirs
```

将文件hello.c编译成一个动态库：libHello.so

* -shared： 该选项指定生成动态连接库（让连接器生成T类型的导出符号表，有时候也生成弱连接W类型的导出符号），不用该标志外部程序无法连接，相当于一个可执行文件；
* -fPIC：PIC指Position Independent Code，表示编译为位置独立的代码，不用此选项的话编译后的代码是位置相关的,所以动态载入时是通过代码拷贝的方式来满足不同进程的需要，而不能达到真正代码段共享的目的。

```
gcc modulars/hello/hello.c -fPIC -shared -o libHello.so
```

生成hello.c文件的动态链接库libHello.so以后，直接在包含hello.h和libHello.so文件夹底下编译  

* -L.：-L后跟连接库的路径，‘.’表示要连接的库在当前目录中；
* -I：表示要连接的头文件所在目录；
* -lHello：编译器查找动态连接库时有隐含的命名规则，即在给出的名字前面加上lib，后面加上.so来确定库的名称（即：libHello.so）。

```
gcc main.c -lHello -L. -I modulars/
```

查看依赖关系  

```
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:`pwd`  
ldd libHello.so
ldd a.out
```

运行测试  

```
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:`pwd`
gcc modulars/hello/hello.c -fPIC -shared -o libHello.so && gcc main.c -lHello -L. -I modulars/ && ./a.out hello 1 2 3 4 5
g++ modulars/hello/hello.c -fPIC -shared -o libHello.so && g++ main.c -lHello -L. -I modulars/ && ./a.out hello 1 2 3 4 5
```

使用shell脚本新增test模块  

```
bash scripts/new_modular.sh test |bash
```
# cmake

CMake是一个跨平台的安装（编译）工具，可以用简单的语句来描述所有平台的安装(编译过程)。他能够输出各种各样的makefile或者project文件，能测试编译器所支持的C++特性,类似UNIX下的automake。  

cmake的所有语句都写在一个CMakeLists.txt的文件中，CMakeLists.txt文件确定后，直接使用cmake命令进行运行，但是这个命令要指向CMakeLists.txt所在的目录，cmake之后就会产生我们想要的makefile文件。  

## cmake_minimum_required

检查cmake的版本  

## project

project 主要用于提供项目的名称、版本、使用编译语言等信息

```
project(<PROJECT-NAME> [<language-name>...])

project(<PROJECT-NAME>
        [VERSION <major>[.<minor>[.<patch>[.<tweak>]]]]
        [DESCRIPTION <project-description-string>]
        [HOMEPAGE_URL <url-string>]
        [LANGUAGES <language-name>...])
```

### PROJECT-NAME

项目名称，配置好值后，会存在　CMAKE_PROJECT_NAME 变量中。  

### VERSION

版本号，主要分为 major（主版本号）、minor（次版本号）、patch（补丁版本号）、tweak， 格式为： 10.2.1.3  
设置对应的值后，会依次解析，存在各自对应的变量里面。  
以 10.2.1.3 为例  

|名称                         |变量名	               |值|
|-----------------------------|------------------------|--|
|major（主版本号）            |PROJECT_VERSION_MAJOR   |10|
|minor（次版本号）            |PROJECT_VERSION_MINOR   |2 |
|patch（补丁版本号)           |PROJECT_VERSION_PATCH   |1 |
|tweak                        |PROJECT_VERSION_TWEAK   |3 |

### LANGUAGES

如果未配置，默认使用 C 以及 CXX。  

## message

打印

```
message("CMAKE_PROJECT_NAME = ${CMAKE_PROJECT_NAME}")
```

## set

```
SET(VAR [VALUE] [CACHE TYPE DOCSTRING [FORCE]]) 
``` 
### EXECUTABLE_OUTPUT_PATH

### LIBRARY_OUTPUT_PATH

## add_subdirectory

添加一个子目录并构建该子目录。  

```
add_subdirectory (source_dir [binary_dir] [EXCLUDE_FROM_ALL])
```

## include_directories

添加编译器用于查找头文件的文件夹，如果文件夹路径是相对路径，则认为该路径是基于当前源文件的路径。  
使用AFTER和BEFORE可以追加或者插入。  

```
include_directories([AFTER|BEFORE] [SYSTEM] dir1 [dir2 ...])
```

## add_library

将指定的源文件生成链接文件，然后添加到工程中去。  

```
add_library(<name> [STATIC | SHARED | MODULE]
            [EXCLUDE_FROM_ALL]
            [source1] [source2] [...])
```

## link_directories

指定要链接的库文件的路径，该指令有时候不一定需要。因为find_package和find_library指令可以得到库文件的绝对路径。  

## add_executable

使用给定的源文件，为工程引入一个可执行文件。  

```
add_executable(<name> [WIN32] [MACOSX_BUNDLE]
               [EXCLUDE_FROM_ALL]
               source1 [source2 ...])
```

## target_link_libraries

将目标文件与库文件进行链接。  

```
target_link_libraries(<target> [item1] [item2] [...]
                      [[debug|optimized|general] <item>] ...)
```


