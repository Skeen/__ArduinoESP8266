#*******************************************************
#
#  Connect to J-Link and debug application in flash.
#

# define 'reset' command
define reset

# Connect to the J-Link gdb server
target remote localhost:2331
# Reset the chip to get to a known state
monitor reset

# Select flash device
monitor flash device = AT91SAM3U4E
# Enable flash download and flash breakpoints
monitor flash download = 1
# Load the program
load

# Reset peripheral  (RSTC_CR)
set *0x400e1200 = 0xA5000004

# Initializing PC and stack pointer
mon reg sp=(0x80000)
set *0x80004 = *0x80004 & 0xFFFFFFFE
mon reg pc=(0x80004)
info reg

break main

# end of 'reset' command
end