OBJDIR = obj/
BINDIR = bin/

all:$(OBJDIR) $(BINDIR)
	mipsel-linux-gcc -mips32 -EL -g -c start.S -o obj/start.o
	mipsel-linux-gcc -mips32 -EL -static -Wall -g -nostdlib -fno-exceptions -fno-builtin -nostartfiles -nodefaultlibs -fno-stack-protector -c main.c -o obj/main.o
	mipsel-linux-ld -EL -T boot.ld obj/start.o obj/main.o -o bin/image.elf
	mipsel-linux-objcopy -O binary bin/image.elf bin/image.bin

$(OBJDIR):
	mkdir -p $@
$(BINDIR):
	mkdir -p $@
clean:
	rm -rf obj bin
