OBJDIR = obj/
BINDIR = bin/

CROSS_COMPILE = mipsel-linux-
CC = $(CROSS_COMPILE)gcc
LD = $(CROSS_COMPILE)ld
AS = $(CROSS_COMPILE)as
AR = $(CROSS_COMPILE)ar
OBJCOPY = $(CROSS_COMPILE)objcopy

CFLAGS += -mips32 -EL -static -Wall -g -nostdlib -fno-exceptions -fno-builtin -nostdinc -fno-stack-protector
LDFLAGS += -nostdlib -nostartfiles -nodefaultlibs -EL

ELF_IMAGE = $(BINDIR)image.elf
TARGET = $(BINDIR)image.bin

LINKER_SCRIPT = boot.ld

APP_OBJS += main.o
STARTUP_OBJ += start.o

OBJS = $(addprefix $(OBJDIR), $(STARTUP_OBJ) $(APP_OBJS))


all: $(TARGET)

$(TARGET):$(OBJDIR) $(BINDIR) $(ELF_IMAGE)
	$(OBJCOPY) -O binary $(ELF_IMAGE) $(TARGET)

$(ELF_IMAGE):$(OBJS)
	$(LD) $(LDFLAGS) -T $(LINKER_SCRIPT) $(OBJS) -o $@


$(OBJDIR)start.o:start.S
	$(CC) $(CFLAGS) -c $< -o $@
$(OBJDIR)main.o:main.c
	$(CC) $(CFLAGS) -c $< -o $@

$(OBJDIR):
	mkdir -p $@
$(BINDIR):
	mkdir -p $@
clean:
	rm -rf obj bin
