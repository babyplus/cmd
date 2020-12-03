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


