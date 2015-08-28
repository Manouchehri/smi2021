# smi2021

The purpose of this repository is to merge and clean up several of the forks available. A merge into the mainline kernel seems possible; the binary blob is under the GPL, but we don't have the source.

## Minimal requirement

- Kernel version must be greater than or equal to 3.12

## Installing

### From you distro.

Ready distro:

- Arch Linux - https://aur.archlinux.org/packages/somagic-easycap-smi2021-git/

> If you've packaged it for another distro, please send me the link and I'll add it.

### Manual build and installation

#### Get source

```
git clone git://github.com/Manouchehri/smi2021.git
cd smi2021/
```

#### Build

You can build that module one of the two options: as `internal` or as `external` (out-of-tree) module.
> if you have been collecting both ways - don't forget that in every way the final installation path of the module are different:
>
> **internal** = ``` /lib/modules/`uname -r`/kernel/drivers/media/usb/smi2021/smi2021.ko ```
>
> **external** = ``` /lib/modules/`uname -r`/extra/smi2021.ko ```
>
> It might be possible - two different module will be in two different place at the same time - don't forget to delete the old module if you change the type of Assembly.

1. Build as **internal**:
  1.  Place folder `smi2021` from **Get source** step in you kernel source tree into folder `drivers/media/usb/`
  2.  In **menuconfig** (or other configuration utilits as xmenuconfig, etc...) Chose ```Device Drivers -> Multimedia support -> Media USB Adapters -> Somagic SMI2021 USB video/audio capture support``` as module or build-in
  3.  Build you kernel with modules and instal it. If you chose `Somagic SMI2021 USB video/audio capture support` as module - install modules too.
    
    > On build it as module - that module installs in ```/lib/modules/`uname -r`/kernel/drivers/media/usb/smi2021/smi2021.ko```

2. Build as **external** (out-of-tree) module.
  1. You **MUST** verify all dependency:
    - `VIDEO_DEV && I2C && SND && USB`
    - `SND_PCM`
    - `VIDEO_SAA711X` = `Device Drivers -> Multimedia support -> Encoders, decoders, sensors and other helper chips -> Philips SAA7111/3/4/5 video decoders`
    - `VIDEOBUF2_VMALLOC` = I simple chose in menuconfig: `Device Drivers -> Multimedia support -> Media USB Adapters -> USB Video Class` - it have needed dependency for `VIDEOBUF2_VMALLOC`
    
    > Im most case, in blank `Encoders, decoders, sensors and other helper chips` and `Media USB Adapters` - when you not select `Cameras/video grabbers support`.
    > Also sufficient **UN**select `Autoselect ancillary drivers (tuners, sensors, i2c, frontends)` for view `Encoders, decoders, sensors and other helper chips` in list. 
  2. As is "https://www.kernel.org/doc/Documentation/kbuild/modules.txt".
    
    > NOTE: "modules_prepare" will not build Module.symvers even if CONFIG_MODVERSIONS is set; therefore, a full kernel build needs to be executed to make module versioning work.
  To build against the running kernel use: ```make -C /lib/modules/`uname -r`/build M=$PWD```
  3. Build module with run `make` in source directory. You can use targets: `modules` as default `modules_install clean help` and `clean_all`. You can use env `CROSS_COMPILE, ARCH, KDIR` and `-j` too.
  4. Install builded module with `make modules_install`.
    
    > NOTE: It installs in ```/lib/modules/`uname -r`/extra/smi2021.ko```

#### Install firmware

After installing the module, you will have to copy `firmware/smi2021_3c.bin` (md5sum: `90f78491e831e8db44cfdd6204a2b602`) as `/usr/lib/firmware/smi2021_3c.bin`. If you Google the hash, you'll find guides that explain how to extract it.

## Module parameters

- forceasgm - default 0. If set to 1 chipset version be set as gm7113C - supported now version in saa7115 modules.
In kernel command line it look like smi2021.forceasgm=1. In build as internal module we can set VIDEO\_SMI2021\_INIT\_AS\_GM7113C, but that not recommended, as module parameter present.
- monochrome - default 0. If set to 1 on init output be in monochrome mode only.
- chiptype - default 0. You can skip autodetection and set chip version directly: 1 = gm7113C, 2 = saa7113.
    - NOTICE: if you set 1 (gm7113C) - saa7115 module can incorrectly detect you chip, because now present some change in registry out and that part in under development. For module work as before - **NEED** use `forceasgm=1`
    - NOTICE: chiptype **NOT** override version for other kernel module. For module work as before - **NEED** use `forceasgm=1`

## Troubleshooting

- monochrome output or no output - you need check, what `saa7115` module proper init you device (need once on first install, or new linux distrib, or with new smi2021 device(for proper check what they detected correct)).
For that check, you need
    1. load saa7115 modules with debug: ```modprobe -r saa7115; modprobe saa7115 debug=1```
    2. load smi2021 and check dmesg: must be string like: ```saa7115 8-004a: gm7113c found @ 0x94 (smi2021)```
If detection not work, or work notproper - try use `forceasgm=1` module option. For build as part of kernel and use override - be added additional options in Kconfig.


## Credits

David Manouchehri - david@davidmanouchehri.com

Jon Arne Jørgensen - jonjon.arnearne@gmail.com

mastervolkov - mastervolkov@gmail.com

https://github.com/Manouchehri/smi2021

https://github.com/jonjonarnearne/smi2021

https://github.com/mastervolkov/smi2021
