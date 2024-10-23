#@copyright : Amir
#FOR Machine 
CC=arm-none-eabi-
#For architecteure
CFLAGS=-g -mcpu=arm926ej-s
#For Liberary or path of header
INCS=-I .
#for static libraries
LIBS=
SRC = $(wildcard *.c)
OBJ = $(SRC:.c=.o)
As = $(wildcard *.s)
AsOBJ = $(As:.s=.o)
Project_Name =learn_in_depth

all: $(Project_Name).bin
	@echo "=========Builg is done========="
	
startup.o: startup.s
	$(CC)as.exe $(CFLAGS) $< -o $@
	
%.o: %.c
	$(CC)gcc.exe $(CFLAGS) $(INCS) -c $< -o $@

$(Project_Name).elf: $(OBJ) $(AsOBJ)
	$(CC)ld.exe  -T  linkerscript.ld $(LIBS) $(OBJ) $(AsOBJ) -o $@ -Map=map_file.map 

$(Project_Name).bin: $(Project_Name).elf
	$(CC)objcopy.exe -O binary $(Project_Name).elf $(Project_Name).bin
	

clean_all:
	rm *.o *.elf *.bin
clean:
	rm *.elf *.bin