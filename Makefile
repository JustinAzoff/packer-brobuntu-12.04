all: cache bro-2.2
cache: src/bro.tgz

bro-2.2: output-brobuntu-vbox-v2.2/brobuntu-v2.2-disk1.vmdk
bro-head: output-brobuntu-vbox-HEAD/brobuntu-HEAD-disk1.vmdk


src/bro.tgz:
	./src/clone_bro

output-lubuntu-vbox/lubuntu-disk1.vmdk:
	time packer build -only=lubuntu-vbox template-base.json

output-brobuntu-vbox-v2.2/brobuntu-v2.2-disk1.vmdk: cache
	time packer build -only=brobuntu-vbox -var 'bro_treeish=v2.2' template-bro.json

output-brobuntu-vbox-HEAD/brobuntu-HEAD-disk1.vmdk: cache
	time packer build -only=brobuntu-vbox -var 'bro_treeish=HEAD' template-bro.json
