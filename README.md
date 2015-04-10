# smi2021

The purpose of this repository is to merge and clean up several of the forks available. A merge into the mainline kernel seems unlikely at the moment, as we don't have licensing on the binary blob that's needed to use the driver.

## Installing

Ideally, grab it from your distro.

Arch Linux - https://aur.archlinux.org/packages/somagic-easycap-smi2021-git/

If you've packaged it for another distro, please send me the link and I'll add it. Just make sure you've removed any smi2021\_\*.bin files, but still left instructions telling the user to get one.

**Warning:** You will have to adjust the forth line depending on what distro you use. Put the module in whichever folder is appropriate.

```
git clone git://github.com/Manouchehri/smi2021.git
cd smi2021/
make -C /lib/modules/$(uname -r)/build M=$PWD modules
printf "I am not blindly copying these lines.\n"
install -Dm644 smi2021.ko /usr/lib/modules/$(printf extramodules-`pacman -Q linux | grep -Po "\d+\.\d+"`-ARCH)/
```

After installing the module, you will have to copy `somagic_firmware.bin` (md5sum: `90f78491e831e8db44cfdd6204a2b602`) as `/usr/lib/firmware/smi2021_3c.bin`. Please do *not* share this file, as it's property of Somagic Inc. (Hang Zhou, China). If you Google the hash, you'll find guides that explain how to extract it.

## Credits

David Manouchehri - david@davidmanouchehri.com

Jon Arne Jørgensen - jonjon.arnearne@gmail.com

mastervolkov - mastervolkov@gmail.com

https://github.com/Manouchehri/smi2021

https://github.com/jonjonarnearne/smi2021

https://github.com/mastervolkov/smi2021
