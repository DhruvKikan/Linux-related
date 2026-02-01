Instruction - 

boot via arch iso
use `iwctl` command to connect to internet
  `device list` then `station <device_name> scan` then `station <device_name> connect <network_name>` then `exit`

then `lsblk` to see drives and partitions

then `cfdisk <path_to_drive/partition>` to see and modify partitions

then `mkfs.file_system_name <-options>` commands to change partition type then mount command to mount files

use `nmtui` or `nmcli` to reconfigure networks if things break

Further instructions regarding systemd boot manager, dual booting with secure boot active and kde plasma gui pending





