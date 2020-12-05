modulars.h: 
	bash new_modular.sh |grep -v a.out |bash

.PHONY: clean
clean:
	rm modulars.h
	rm *.so

push:
	rm -rf modulars/test/
	rm modulars.h
	bash new_modular.sh |grep -v a.out |bash
	git add .
	git commit -m "auto commit by make"
	git push
