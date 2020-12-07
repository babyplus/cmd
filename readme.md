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

清除多余文件(动态链接库)  

```
make clean
```

生成modulars.h  

```
rm -f modulars.h
make modulars.h
```

提交到仓库(不提交目录modulars/test\*/并且重新生成modulars.h)  

```
make push
```

# make

Makefile文件由一系列规则（rules）构成。每条规则的形式如下。  
第一行冒号前面的部分，叫做"目标"（target），冒号后面的部分叫做"前置条件"（prerequisites）；第二行必须由一个tab键起首，后面跟着"命令"（commands）。  
"目标"是必需的，不可省略；"前置条件"和"命令"都是可选的，但是两者之中必须至少存在一个。  
每条规则就明确两件事：构建目标的前置条件是什么，以及如何构建。  

```
<target> : <prerequisites> 
[tab]  <commands>
```

## target

一个目标（target）就构成一条规则。目标通常是文件名，指明Make命令所要构建的对象，比如上文的 a.txt 。目标可以是一个文件名，也可以是多个文件名，之间用空格分隔。  
除了文件名，目标还可以是某个操作的名字，这称为"伪目标"（phony target）。  
但是，如果当前目录中，正好有一个文件叫做clean，那么这个命令不会执行。因为Make发现clean文件已经存在，就认为没有必要重新构建了，就不会执行指定的rm命令。  
为了避免这种情况，可以明确声明clean是"伪目标"，写法如下。  

```
.PHONY: clean
clean:
	rm *.so
```

