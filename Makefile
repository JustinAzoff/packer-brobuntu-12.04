VER=v2.3
FILESETS=none
all: brobuntu

cache: src/bro.tgz get-filesets

src/bro.tgz:
	./src/clone_bro

get-filesets:
	./get_filesets.py $(FILESETS)

base: output/lubuntu-vbox/lubuntu-disk1.vmdk

output/lubuntu-vbox/lubuntu-disk1.vmdk:
	time packer build -only=lubuntu-vbox template-base.json

brobuntu: cache base output/brobuntu-vbox-$(VER)-$(FILESETS)/brobuntu-$(VER)-$(FILESETS)-disk1.vmdk

template-bro-filesets-$(FILESETS).json: get-filesets
	./inject_filesets.py template-bro.json template-bro-filesets-$(FILESETS).json filesets-$(FILESETS).json $(FILESETS)

output/brobuntu-vbox-$(VER)-$(FILESETS)/brobuntu-$(VER)-$(FILESETS)-disk1.vmdk: template-bro-filesets-$(FILESETS).json
	mkdir -p output
	time packer build -only=brobuntu-vbox -var 'bro_treeish=$(VER)' -var 'bro_filesets=$(FILESETS)' template-bro-filesets-$(FILESETS).json
