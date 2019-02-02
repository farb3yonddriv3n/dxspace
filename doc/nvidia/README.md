# Introduction

Debian Nvidia drivers

## Remove existing modules

Remove nouveau module:

```sh
cat /etc/modprobe.d/blacklist-nvidia-nouveau.conf
blacklist nouveau
options nouveau modeset=0
update-initramfs -u
```

## Prepare libraries

```sh
dpkg --add-architecture i386
apt update
apt-get install libglvnd-dev libc6:i386
```
