# 这里使用 linker script 的方式去指定数据段和代码段

CC = riscv32-unknown-elf-gcc
CFLAGS = -march=rv32i_zicsr \
		-mabi=ilp32 \
		-nostartfiles \
		-g \

SRC = start.s main.c

READELF = riscv32-unknown-elf-readelf
OBJDUMP = riscv32-unknown-elf-objdump
OBJCOPY = riscv32-unknown-elf-objcopy
NM = riscv32-unknown-elf-nm
SIZE = riscv32-unknown-elf-size

LDFLAG =my.ld


# build
$(shell mkdir -p build)

all:
	$(CC) $(CFLAGS) -T $(LDFLAG) -o build/x.elf $(SRC)
	$(READELF) -a build/x.elf > build/x.readelf.txt
	$(OBJDUMP) -d -S build/x.elf > build/x.objdump.txt
	$(OBJCOPY) -O ihex build/x.elf build/x.hex
	$(OBJCOPY) -O binary build/x.elf build/x.bin
	$(NM) build/x.elf > build/x.nm
	$(SIZE) build/x.elf

# 用于$readmemh		bin 文件可以用 od 工具查看 : od -An -t x4 -w4 build/code.bin
	$(OBJCOPY) --dump-section .data=build/data.bin build/x.elf
	$(OBJCOPY) --dump-section .text=build/code.bin build/x.elf
	hexdump -v -e '1/4 "%08x\n"' build/data.bin > build/data.hex
	hexdump -v -e '1/4 "%08x\n"' build/code.bin > build/code.hex

clean:
	rm -rf build

.PHONY: all clean

