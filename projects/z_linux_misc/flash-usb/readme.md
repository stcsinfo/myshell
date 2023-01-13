1. Find your USB
 fdisk -l
 
2. Unmount USB

 sudo umount /dev/name
 
3. Download iso and move to the directory

 cd /path
 
4. Write the iso to the USB

sudo dd if=iso-file.iso of=/dev/name