VER=v2.2
FILESET=""
all: brobuntu

cache: src/bro.tgz get-fileset

src/bro.tgz:
	./src/clone_bro

get-fileset:
	./get_fileset.py $(FILESET)

base: output-lubuntu-vbox/lubuntu-disk1.vmdk

output-lubuntu-vbox/lubuntu-disk1.vmdk:
	time packer build -only=lubuntu-vbox template-base.json

brobuntu: cache base output-brobuntu-vbox-$(VER)/brobuntu-$(VER)-disk1.vmdk

output-brobuntu-vbox-$(VER)/brobuntu-$(VER)-disk1.vmdk:
	time packer build -only=brobuntu-vbox -var 'bro_treeish=$(VER)' template-bro.json
