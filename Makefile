ifneq ($(KERNELRELEASE),)
# kbuild part of makefile
smi2021-y := smi2021_main.o		\
	     smi2021_bootloader.o	\
	     smi2021_v4l2.o		\
	     smi2021_audio.o		\


obj-$(CONFIG_VIDEO_SMI2021) += smi2021.o

ifeq ($(GIT_VERSION),)
GIT_VERSION := $(shell cd $(src) && git show -s --format=%h)
endif
$(info ** GIT MODULE VERSION = $(GIT_VERSION) **)

ccflags-y += -Idrivers/media/i2c -DGITVERSION=\"-$(GIT_VERSION)\"
else
# normal makefile

ifeq ($(KDIR),)
KDIR := $(shell echo /lib/modules/`uname -r`/build)
else
$(info ** KDIR = $(KDIR) **)
endif

ifeq ($(ARCH),)
OVERRIDE_ARCH := 
else
OVERRIDE_ARCH := ARCH=$(ARCH)
endif

ifeq ($(CROSS_COMPILE),)
OVERRIDE_CROSS_COMPILE := 
else
OVERRIDE_CROSS_COMPILE := CROSS_COMPILE=$(CROSS_COMPILE)
endif

CURR_PWD := $(shell pwd)
export CONFIG_VIDEO_SMI2021=m
export GIT_VERSION=$(shell cd $(CURR_PWD) && git show -s --format=%h)

KCONFIG_DEF_TARGET += modules modules_install clean help
MODULE_SPECIFIC_TARGET += clean_all dsad

PHONY += $(KCONFIG_DEF_TARGET) $(MODULE_SPECIFIC_TARGET)
.PHONY: $(PHONY)
.DEFAULT_GOAL := modules

.PHONY: $(KCONFIG_DEF_TARGET)
$(KCONFIG_DEF_TARGET):
	$(MAKE) $(OVERRIDE_ARCH) $(OVERRIDE_CROSS_COMPILE) -C $(KDIR) M=$(CURR_PWD) -I$(KDIR)/drivers/media/i2c $@

# Module specific targets
.PHONY: clean_all
clean_all:
	-rm -f *.o *~ core .depend .*.cmd *.ko *.mod.c modules.order Module.symvers
	-rm -rf .tmp_versions

endif
