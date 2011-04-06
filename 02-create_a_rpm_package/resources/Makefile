helloworld: helloworld.c
	gcc helloworld.c -o helloworld
#   ^-- you need a tab here, not spaces

INST_LOCATION=/usr/local/bin

install: helloworld-install

helloworld-install:
	mkdir -p $(BUILDROOT)$(INST_LOCATION) 
	cp helloworld $(BUILDROOT)$(INST_LOCATION)
	chmod 755 $(BUILDROOT)$(INST_LOCATION)/helloworld
#   ^-- you need a tab here, not spaces

