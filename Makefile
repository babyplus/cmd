all: main

.PHONY: clean_modulars.h
clean_modulars.h:
	rm -f modulars.h

.PHONY: clean_modulars_test
clean_modulars_test:
	rm -rf modulars/test*

.PHONY: clean
clean:
	rm -f *.so
	rm -rf libs/*

modulars.h: clean_modulars.h 
	bash scripts/new_modular.sh &> /dev/null

-lHello: libHello.so
-lTest2: libTest2.so

a.out: -lHello -lTest2
	gcc /home/plus/cmd/main.c $^ -L /home/plus/cmd/libs -I /home/plus/cmd/modulars

main: modulars.h a.out
	./a.out hello 1 2 3 4 5

libHello.so:
	gcc /home/plus/cmd/modulars/hello/hello.c -fPIC -shared -o /home/plus/cmd/libs/libHello.so

libTest2.so:
	gcc /home/plus/cmd/modulars/test2/test2.c -fPIC -shared -o /home/plus/cmd/libs/libTest2.so

push: clean_modulars.h clean_modulars_test clean modulars.h
	git add .
	git commit -m "auto commit by make"
#	git push -f
