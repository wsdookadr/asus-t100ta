#!/usr/bin/env python
"""
Upstream: https://gist.github.com/kylemanna/5692543
Blog post: https://blog.kylemanna.com/linux/parse-emmc-extended-csd-ecsd-registers-with-python/

Description: Get eMMC health information
Tested on ASUS T100TA
Example:

    root@fedora:/home/user# ./emmc_health.py  | rg -i 'LIFE|HEALTH|EOL'
    SLC_DEVICE_HEALTH_STATUS[87] = 0x0
    SLC_DEVICE_HEALTH_STATUS[87] = 0x0
    MLC_DEVICE_HEALTH_STATUS[94] = 0x0
    PRE_EOL_INFO[267] = 0x0
    DEVICE_LIFE_TIME_EST_TYP_A[268] = 0x0
    DEVICE_LIFE_TIME_EST_TYP_B[269] = 0x8

Check the datasheet of the eMMC or https://wiki.friendlyelec.com/wiki/index.php/EMMC
on how to interpret the last value above.
Datasheet: https://www.mouser.com/datasheet/2/669/sandisk_sand-s-a0002728608-1-1747670.pdf
"""
import binascii
import re
import sys
import os

def str2bytearray(s):
  if len(s) % 2:
    s = '0' + s

  reorder = True
  if reorder:
    r = []
    i = 1
    while i <= len(s):
      r.append(s[len(s) - i - 1])
      r.append(s[len(s) - i])
      i += 2
    s = ''.join(r)

  out = bytearray(binascii.unhexlify(s))

  return out


if __name__ == '__main__':

  os.system("umount /d")
  os.system("mount -t debugfs debugfs /d")

  ecsd_str = ''
  with open('/d/mmc1/mmc1:0001/ext_csd','r') as f:
      ecsd_str = f.read().rstrip()
  
  ecsd = str2bytearray(ecsd_str)

  line_len = 16
  i = 0
  while i < len(ecsd):
    sys.stdout.write("{0:04x}:\t".format(i))
    for j in range(line_len):
      if (i < len(ecsd)):
        sys.stdout.write("{0:=02x}".format(ecsd[i]))
        i = i + 1
      else:
        break

      if (j == (line_len - 1)): pass
      elif (i % 4): sys.stdout.write(" ")
      else: sys.stdout.write("   ")

    sys.stdout.write("\n")

  print("SECURE_REMOVAL_TYPE[16] = 0x{:x}".format(ecsd[16]))
  print("SLC_DEVICE_HEALTH_STATUS[87] = 0x{:x}".format(ecsd[87]))
  print("SLC_DEVICE_HEALTH_STATUS[87] = 0x{:x}".format(ecsd[87]))
  print("MLC_DEVICE_HEALTH_STATUS[94] = 0x{:x}".format(ecsd[94]))
  print("SEC_BAD_BLK_MGMNT[134] = 0x{:x}".format(ecsd[134]))
  print("RPMB_SIZE_MULT[168] = 0x{:x}".format(ecsd[168]))
  print("FW_CONFIG[169] = 0x{:x}".format(ecsd[169]))
  print("ERASE_GROUP_DEF[175] = 0x{:x}".format(ecsd[175]))
  print("EXT_CSD_REV[192] = 0x{:x}".format(ecsd[192]))
  print("CSD_STRUCTURE[194] = 0x{:x}".format(ecsd[194]))
  print("CARD_TYPE[196] = 0x{:x}".format(ecsd[196]))
  print("ERASE_TIMEOUT_MULT[223] = 0x{:x}".format(ecsd[223]))
  print("HC_ERASE_GRP_SIZE[224] = 0x{:x}".format(ecsd[224]))
  print("BOOT_SIZE_MULT[226] = 0x{:x}".format(ecsd[226]))
  print("BOOT_INFO[228] = 0x{:x}".format(ecsd[228]))
  print("SEC_TRIM_MULT[229] = 0x{:x}".format(ecsd[229]))
  print("SEC_ERASE_MULT[230] = 0x{:x}".format(ecsd[230]))
  print("SEC_FEATURE_SUPPORT[231] = 0x{:x}".format(ecsd[231]))
  print("PRE_EOL_INFO[267] = 0x{:x}".format(ecsd[267]))
  print("DEVICE_LIFE_TIME_EST_TYP_A[268] = 0x{:x}".format(ecsd[268]))
  print("DEVICE_LIFE_TIME_EST_TYP_B[269] = 0x{:x}".format(ecsd[269]))
