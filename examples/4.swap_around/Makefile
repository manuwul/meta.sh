CC = gcc
GENFILE = gen_main.py
METALANG = $(CC)
META = ../../meta.sh

meta: main.py
	$(META) -m "$(METALANG) -x c -o meta - && ./meta && rm -f ./meta" -i main.py -o $(GENFILE)

clean:
	rm -f main $(GENFILE)
