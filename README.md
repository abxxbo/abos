# abos
A hobbyist operating system written in Assembly. It targets the x86 architecture.

## Compilation

To compile, there are a few dependencies that are required to compile / run:
- NASM
- GNU cat (or any variant of `cat`)
- QEmu (to run in an emulator, not really required)

Once dependencies are installed, you can run `make abos`. If you would like to
test abos as well as compile it, run `make`.

### A warning to modern hardware
As of early July, abos does not support VESA. Soon (hopefully in less than a month)
VESA will be implemented. This will allow it to run on real hardware, since no
modern hardware today actually comes with a VGA driver, rather, "a VESA driver".

## KAb
KAb is the scripting language written for AbOS. The spec is located
[here](./lang/spec.txt).

## Releases
If you want to get the most stable version of AbOS, you can check the releases
tab. Each release contains:
- Floppy version (for a live version of the OS, as well as a portable version of it)

***Disclaimer:*** The current version of ABOS writes to the hard disk instead of floppy.
This will be changed in the future.

### Why is PSI in the release name?
To be honest, I really like Greek characters. It does not have any real effect
on the OS.
