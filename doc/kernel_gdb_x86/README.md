# Introduction

Linux kernel x86 gdb debugging under QEMU using buildroot and rootfs.

## buildroot

Get buildroot source code and build it:

```sh
make qemu_x86_defconfig
sed -i -e 's/tty1/ttyS0/g' .config
make
```
## Linux kernel

Get source code, modify flags and build.

Disable flags:
```sh
CONFIG_RELOCATABLE
```

Enable flags:
```sh
CONFIG_DEBUG_INFO
CONFIG_GDB_SCRIPTS
CONFIG_EXT2_FS
```

with commands:

```sh
ARCH=x86 make O=../obj/linux_x86 i386_defconfig menuconfig
make O=../obj/linux_x86 -j4
```

## QEMU

Run qemu:

```sh
qemu-system-i386 --kernel path/to/bzImage \
    -s \
    -S \
    -nographic \
    -hda path/to/rootfs.ext2 \
    -append "console=ttyS0 root=/dev/sda"
```

## gdb

Specify gdb init file **linux_x86.gdb**:

```sh
symbol-file path/to/vmlinux
set arch i386
target remote :1234
b start_kernel
la src
c
```

Run gdb with the following command when qemu is already running:

```sh
gdb -x linux_x86.gdb
```

Your QEMU VM should break at start_kernel().
