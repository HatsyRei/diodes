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
DTC ?= dtc

gpio-diodes.ko:
	$(MAKE) -C $(KDIR) M=$$PWD modules

all: 	module \
	pi4ioe5v-overlay.dtbo

.PHONY : module clean

module: gpio-diodes.ko

clean:
	$(MAKE) -C $(KDIR) M=$$PWD clean
	rm -f $(usr)

pi4ioe5v-overlay.dtbo:	pi4ioe5v-overlay.dts
	$(DTC) -O dtb -o pi4ioe5v-overlay.dtbo -b 0 -@ pi4ioe5v-overlay.dts

endif
