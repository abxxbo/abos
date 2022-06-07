BOOTLOADER:
1. ~~allow user to choose resolution (default is 80x25)~~

KERNEL:
1. file system implementation
2. rewrite shell (very scuffed)
3. more commands (see below for some that should be added)
  - shut down (requires ACPI, though)
  - reboot    (easy, far jump to reset vector (0xFFFF:0))
4. text editor
5. potentially add a login system

PORTS:
- nyan cat
- DOOM (eventually, though it will require me to rewrite it 100% in
        assembly)
