include ../common.mak

all: 

install: all
	install -D ss-local $(INSTALLDIR)/bin/ss-local
	$(STRIP) $(INSTALLDIR)/bin/ss-local
	chmod 0500 $(INSTALLDIR)/bin/ss-local
	install -D start_shadowsocks $(INSTALLDIR)/bin/start_shadowsocks
	chmod 0500 $(INSTALLDIR)/bin/start_shadowsocks
clean:

