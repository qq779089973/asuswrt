include ../common.mak

SRC_NAME=aria2-1.17.1

CFLAGS  += -ffunction-sections -fdata-sections
CXXFLAGS += -ffunction-sections -fdata-sections
LDFLAGS += -Wl,--gc-sections

THISDIR = $(shell pwd)

all:config_test
	$(MAKE) -C $(SRC_NAME)

config_test:
	( if [ -f ./config_done ]; then \
		echo "the same configuration"; \
	else \
		cd $(SRC_NAME) && autoreconf -i; \
		cd $(THISDIR); \
		make configure && touch config_done; \
	fi )

configure:
	( cd $(SRC_NAME) ; \
        ./configure \
		--prefix=/usr \
                --disable-nls \
                --disable-xmltest \
                --without-libnettle \
                --without-libgmp \
                --without-libgcrypt \
                --without-libexpat \
                --without-libcares \
                --without-sqlite3 \
                --without-gnutls \
                --without-libz \
                --with-openssl \
                --without-libxml2 \
		CC=/opt/brcm/hndtools-mipsel-linux/bin/mipsel-linux-gcc \
		PKG_CONFIG=/usr/lib/pkgconfig \
		OPENSSL_CFLAGS="-I$(TOP)/openssl/include" \
		OPENSSL_LIBS="-L$(TOP)/openssl -lssl -lcrypto" \
                --host=mipsel-linux \
                --build=i386-linux-gnu ; \
        )

clean:
	if [ -f $(SRC_NAME)/Makefile ] ; then \
		$(MAKE) -C $(SRC_NAME) distclean ;\
	fi; \
	rm -f config_done
	rm -rf install

install:
	install -D $(THISDIR)/$(SRC_NAME)/src/aria2c $(INSTALLDIR)/bin/aria2c
	$(STRIP) $(INSTALLDIR)/bin/aria2c
	chmod 0500 $(INSTALLDIR)/bin/aria2c
	install -D /opt/brcm/hndtools-mipsel-linux/lib/libstdc++.so.6.0.9 $(INSTALLDIR)/usr/lib/libstdc++.so.6.0.9
	cd $(INSTALLDIR)/usr/lib && ln -sf libstdc++.so.6.0.9 libstdc++.so.6
