OBJDIR = obj/
BINDIR = bin/
DRVDIR = Drivers/

CROSS_COMPILE = mipsel-linux-
CC = $(CROSS_COMPILE)gcc
LD = $(CROSS_COMPILE)ld
AS = $(CROSS_COMPILE)as
AR = $(CROSS_COMPILE)ar
OBJCOPY = $(CROSS_COMPILE)objcopy

SYS_INC = include/
DRV_INC =Drivers/include/
INC_FLAGS += -I$(SYS_INC) -I$(DRV_INC)

CFLAGS += -mips32 -EL -Wall -g -fno-exceptions -fno-builtin -mno-abicalls -nostdinc -fno-stack-protector
LDFLAGS += -nostdlib -nostartfiles -nodefaultlibs -EL

ELF_IMAGE = $(BINDIR)image.elf
TARGET = $(BINDIR)image.bin

LINKER_SCRIPT = boot.ld

APP_OBJS += main.o
STARTUP_OBJ += start.o
DRIVER_OBJ += uart.o

OBJS = $(addprefix $(OBJDIR), $(STARTUP_OBJ) $(DRIVER_OBJ) $(APP_OBJS))

all: $(TARGET)

$(TARGET):$(OBJDIR) $(BINDIR) $(ELF_IMAGE)
	$(OBJCOPY) -O binary $(ELF_IMAGE) $(TARGET)

$(ELF_IMAGE):$(OBJS)
	$(LD) $(LDFLAGS) -T $(LINKER_SCRIPT) $(OBJS) -o $@


$(OBJDIR)start.o:start.S
	$(CC) $(CFLAGS) -c $< -o $@
$(OBJDIR)main.o:main.c
	$(CC) $(CFLAGS) $(INC_FLAGS) -c $< -o $@

# Drivers
$(OBJDIR)uart.o:$(DRVDIR)uart.c
	$(CC) $(CFLAGS) $(INC_FLAGS) -c $< -o $@


$(OBJDIR):
	mkdir -p $@
$(BINDIR):
	mkdir -p $@
clean:
	rm -rf obj bin
