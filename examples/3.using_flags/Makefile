RC = rustc
GENFILE = gen_main.rs
METALANG = lua
META = ../../meta.sh

main: $(GENFILE)
	$(RC) $(GENFILE) -o main

$(GENFILE): main.rs
	$(META) -d "@" -m "$(METALANG)" -i main.rs -o $(GENFILE)

clean:
	rm -f main $(GENFILE)
