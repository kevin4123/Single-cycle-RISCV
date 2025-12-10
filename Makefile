# mingw32-make

# Variables
TB = "$(CURDIR)/user/sim/tb_top.v"
TARGET = "$(CURDIR)/prj/icarus/tb_top.vvp"
SRC = $(wildcard $(CURDIR)/user/src/*.v)

# Rules
all: icarus
	@echo "=========="
	iverilog.exe -g2012 -o $(TARGET) -s tb_top $(TB) $(SRC)
	@echo "=========="
	vvp $(TARGET)
	@echo "=========="
	
icarus:
	@echo "=========="
	if not exist "$(CURDIR)\prj\icarus" mkdir "$(CURDIR)\prj\icarus"	

clean:
	@echo "=========="
	rm -rf prj/icarus


.PHONY: clean


# Debug Info
$(info ==========================================================)
$(info TB = $(TB))
$(info TARGET = $(TARGET))
$(info SOURCES = $(SRC))
$(info ==========================================================)

