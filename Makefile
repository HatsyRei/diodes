#
# file : Makefile
# desc : Build linux device driver
#

krn = gpio-diodes

ifneq ($(KERNELRELEASE),)

obj-m := $(krn).o

else

KDIR ?= /lib/modules/$$(uname -r)/build
CC = $(CROSS_COMPILE)gcc

module:
	$(MAKE) -C $(KDIR) M=$$PWD modules

clean:
	$(MAKE) -C $(KDIR) M=$$PWD clean
	rm -f $(usr)

all: module

.PHONY : clean
endif
