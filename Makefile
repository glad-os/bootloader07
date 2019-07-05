#
# Copyright 2019 AbbeyCatUK
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
# http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# common
OPTIMIZE			= 2
FIND				= find

# 32-bit toolchain
GCC_PATH_32			= ~/Downloads/Software/ARM/32-bit/gcc-arm-8.2-2019.01-x86_64-arm-eabi
GCC_32      			= $(GCC_PATH_32)/bin/arm-eabi-gcc
AS_32       			= $(GCC_PATH_32)/arm-eabi/bin/as
AR_32       			= $(GCC_PATH_32)/arm-eabi/bin/ar
LD_32       			= $(GCC_PATH_32)/arm-eabi/bin/ld
OBJDUMP_32  			= $(GCC_PATH_32)/arm-eabi/bin/objdump
OBJCOPY_32  			= $(GCC_PATH_32)/arm-eabi/bin/objcopy

# 64-bit toolchain
GCC_PATH_64			= ~/Downloads/Software/ARM/64-bit/gcc-arm-8.2-2019.01-x86_64-aarch64-elf
GCC_64      			= $(GCC_PATH_64)/bin/aarch64-elf-gcc
AS_64       			= $(GCC_PATH_64)/aarch64-elf/bin/as
AR_64       			= $(GCC_PATH_64)/aarch64-elf/bin/ar
LD_64       			= $(GCC_PATH_64)/aarch64-elf/bin/ld
OBJDUMP_64  			= $(GCC_PATH_64)/aarch64-elf/bin/objdump
OBJCOPY_64  			= $(GCC_PATH_64)/aarch64-elf/bin/objcopy

# 32/64 bit flags for Assembler and Compiler
ARCH_64	 			= 
FLAGS_C_64  			= -Wall -O$(OPTIMIZE) -nostdlib -nostartfiles -ffreestanding -D ISA_TYPE=$(ISA_TYPE)
FLAGS_A_64			= $(ARCH_64) -O$(OPTIMIZE) -D ISA_TYPE=$(ISA_TYPE)
FILES_A_64			= $(patsubst %.s,%.s,$(shell find asm/64-bit -type f -name '*.s'))

ARCH_32	 			= 
FLAGS_C_32  			= -Wall -O$(OPTIMIZE) -nostdlib -nostartfiles -ffreestanding -D ISA_TYPE=$(ISA_TYPE)
FLAGS_A_32			= $(ARCH_32) -O$(OPTIMIZE) -D ISA_TYPE=$(ISA_TYPE)
FILES_A_32			= $(patsubst %.s,%.s,$(shell find asm/32-bit -type f -name '*.s'))

# -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  

# 32-bit
32-bit: build

32-bit: ISA_TYPE		= 32

32-bit: GCC			= $(GCC_32)
32-bit: AS			= $(AS_32)
32-bit: AR			= $(AR_32)
32-bit: LD			= $(LD_32)
32-bit: OBJDUMP			= $(OBJDUMP_32)
32-bit: OBJCOPY			= $(OBJCOPY_32)

32-bit: FLAGS_C			= $(FLAGS_C_32)
32-bit: FLAGS_A			= $(FLAGS_A_32)
32-bit: FILES_A			= $(FILES_A_32)

32-bit: KERNEL_NAME		= kernel

# -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  

# 64-bit
64-bit: build

64-bit: ISA_TYPE		= 64

64-bit: GCC			= $(GCC_64)
64-bit: AS			= $(AS_64)
64-bit: AR			= $(AR_64)
64-bit: LD			= $(LD_64)
64-bit: OBJDUMP			= $(OBJDUMP_64)
64-bit: OBJCOPY			= $(OBJCOPY_64)

64-bit: FLAGS_C			= $(FLAGS_C_64)
64-bit: FLAGS_A			= $(FLAGS_A_64)
64-bit: FILES_A			= $(FILES_A_64)

64-bit: KERNEL_NAME		= kernel8

# -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  

# build
build: clean kernel

# -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  

# clean
clean:
	$(FIND) . -name "*.o"    -type f -delete
	$(FIND) . -name "*.bin"  -type f -delete
	$(FIND) . -name "*.hex"  -type f -delete
	$(FIND) . -name "*.elf"  -type f -delete
	$(FIND) . -name "*.list" -type f -delete
	$(FIND) . -name "*.img"  -type f -delete

# -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  

# kernel
kernel: vectors.o periph.o bootloader07.o
	$(LD) asm/$(ISA_TYPE)-bit/vectors.o periph.o bootloader07.o -T loader -o $(KERNEL_NAME).elf
	$(OBJDUMP) -D $(KERNEL_NAME).elf >         $(KERNEL_NAME).list
	$(OBJCOPY)    $(KERNEL_NAME).elf -O ihex   $(KERNEL_NAME).hex
	$(OBJCOPY)    $(KERNEL_NAME).elf -O binary $(KERNEL_NAME).img

vectors.o : $(FILES_A)
	$(GCC) $(FLAGS_A) -c asm/$(ISA_TYPE)-bit/vectors.s -o asm/$(ISA_TYPE)-bit/vectors.o

periph.o : periph.c
	$(GCC) $(FLAGS_C) -c periph.c -o periph.o -DRPI2

bootloader07.o : bootloader07.c
	$(GCC) $(FLAGS_C) -c bootloader07.c -o bootloader07.o

