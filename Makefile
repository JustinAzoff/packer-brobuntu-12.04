VER=v2.2
FILESETS=none
all: brobuntu

cache: src/bro.tgz get-filesets

src/bro.tgz:
	./src/clone_bro

get-filesets:
	./get_filesets.py $(FILESET)

base: output-lubuntu-vbox/lubuntu-disk1.vmdk

output-lubuntu-vbox/lubuntu-disk1.vmdk:
	time packer build -only=lubuntu-vbox template-base.json

brobuntu: cache base output-brobuntu-vbox-$(VER)/brobuntu-$(VER)-disk1.vmdk

template-bro-filesets-$(FILESETS).json: get-filesets
	./inject_filesets.py template-bro.json template-bro-filesets-$(FILESETS).json

output-brobuntu-vbox-$(VER)/brobuntu-$(VER)-disk1.vmdk: template-bro-filesets-$(FILESETS).json
	time packer build -only=brobuntu-vbox -var 'bro_treeish=$(VER)' template-bro-filesets-$(FILESETS).json
