include ../common.mak

CFLAGS += -I. -I$(LINUXDIR)/drivers/char -I$(LINUXDIR)/include/asm/mach-ralink -DCONFIG_RALINK_MT7620
EXEC = gpio

all: $(EXEC)

$(EXEC): $(EXEC).c
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $@.c

install: all
	install -D $(EXEC) $(INSTALLDIR)/bin/$(EXEC)
	$(STRIP) $(INSTALLDIR)/bin/$(EXEC)
	chmod 0500 $(INSTALLDIR)/bin/$(EXEC)

clean:
	-rm -f $(EXEC) *.o

