include ../common.mak

SRC_NAME=src

THISDIR = $(shell pwd)

all:install

install:
	rm -rf $(INSTALLDIR)/aria2_web/
	mkdir -p $(INSTALLDIR)/aria2_web/
	cp -r $(THISDIR)/$(SRC_NAME)/* $(INSTALLDIR)/aria2_web/
	chmod -R 777 $(INSTALLDIR)/aria2_web/*
	mkdir -p $(INSTALLDIR)/www/
	cd $(INSTALLDIR)/www/ && ln -sf ../aria2_web/ aria2_web
clean:

