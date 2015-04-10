# smi2021

The purpose of this repository is to merge and clean up several of the forks available. A merge into the mainline kernel seems unlikely at the moment, as we don't have licensing on the binary blob that's needed to use the driver.

## Installing

Ideally, grab it from your distro.

- Arch Linux - https://aur.archlinux.org/packages/somagic-easycap-smi2021-git/

If you've packaged it for another distro, please send me the link and I'll add it. Just make sure you've removed any `smi2021_*.bin` files, but still left instructions telling the user to get one.

**Warning:** You will have to adjust the fifth line depending on what distro you use. Put the module in whichever folder is appropriate.

```
git clone git://github.com/Manouchehri/smi2021.git
cd smi2021/
sed -i '0,/obj/{s/$(CONFIG_VIDEO_SMI2021)/m/}' Makefile # Force building as a module.
make -C /lib/modules/$(uname -r)/build M=$PWD modules
printf "I am not blindly copying these lines.\n"
install -Dm644 smi2021.ko /usr/lib/modules/$(printf extramodules-`pacman -Q linux | grep -Po "\d+\.\d+"`-ARCH)/ # This line is going to have to change.
```

##Short module build instruction

```
Module compile:
	Internal:
		1. Place folder "smi2021" with source in "drivers/media/usb/"
		2. In "menuconfig" (or other configuration utilits as xmenuconfig, etc...) Chose "Device Drivers -> Multimedia support -> Media USB Adapters -> Somagic SMI2021 USB video/audio capture support" as module or build-in
		3. Build you kernel with modules and instal it. If you chose "Somagic SMI2021 USB video/audio capture support" as modules.
			NOTE: It installs in "/lib/modules/`uname -r`/kernel/drivers/media/usb/smi2021/smi2021.ko"
	External:
		1. Verify all dependency: 
			"VIDEO_DEV && I2C && SND && USB"
			"SND_PCM" = 
			"VIDEO_SAA711X" = "Device Drivers -> Multimedia support -> Encoders, decoders, sensors and other helper chips -> Philips SAA7111/3/4/5 video decoders"
			"VIDEOBUF2_VMALLOC" (I simple chose in menuconfig: "Device Drivers -> Multimedia support -> Media USB Adapters -> USB Video Class" - it have needed dependency for "VIDEOBUF2_VMALLOC")
		2. As is "https://www.kernel.org/doc/Documentation/kbuild/modules.txt".
			NOTE: "modules_prepare" will not build Module.symvers even if CONFIG_MODVERSIONS is set; therefore, a full kernel build needs to be executed to make module versioning work.
				To build against the running kernel use: "make -C /lib/modules/`uname -r`/build M=$PWD"
		3. Build module with run "make" in source directory. You can use targets: "modules(default) modules_install clean help" and clean_all. You can use env "CROSS_COMPILE, ARCH, KDIR" and "-j" too.
		3. Install builded module with "make modules_install".
			NOTE: It installs in "/lib/modules/`uname -r`/extra/smi2021.ko"
```


After installing the module, you will have to copy `somagic_firmware.bin` (md5sum: `90f78491e831e8db44cfdd6204a2b602`) as `/usr/lib/firmware/smi2021_3c.bin`. Please do *not* share this file, as it's property of Somagic Inc. (Hang Zhou, China). If you Google the hash, you'll find guides that explain how to extract it.

## Credits

David Manouchehri - david@davidmanouchehri.com

Jon Arne Jørgensen - jonjon.arnearne@gmail.com

mastervolkov - mastervolkov@gmail.com

https://github.com/Manouchehri/smi2021

https://github.com/jonjonarnearne/smi2021

https://github.com/mastervolkov/smi2021
