modulars.h: 
	bash scripts/new_modular.sh |grep -v a.out |bash

.PHONY: clean
clean:
	rm -f *.so
	rm -rf libs/*

push:
	rm -rf modulars/test*
	rm -f modulars.h
	make clean
	make modulars.h
	git add .
	git commit -m "auto commit by make"
	git push -f
