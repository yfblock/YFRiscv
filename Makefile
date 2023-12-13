VERILOG_FILE := src/verilog/MyTopLevel.v
SOURCES = src/spinal/io/github/yfblock/yfriscv/*.scala
BITSTREAM_FILE := board/gowin/impl/pnr/yfriscv.fs
REPORT_FILE := board/gowin/impl/pnr/yfriscv.rpt.txt
GW_SH := gw_sh

all:

$(VERILOG_FILE): $(SOURCES) build.sbt
	sbt "runMain io.github.yfblock.yfriscv.MyTopLevelVerilog"

verilog: $(VERILOG_FILE)

$(BITSTREAM_FILE) $(REPORT_FILE): $(VERILOG_FILE) board/gowin/src/*.tcl
	cp $(VERILOG_FILE) board/gowin/src
	cd board/gowin && $(GW_SH) src/synth.tcl
	@cat $(REPORT_FILE) | grep -A32 "Resource Usage Summary"

flash-gowin: $(BITSTREAM_FILE)
	openFPGALoader -b tangnano9k $< -f


load-gowin: $(BITSTREAM_FILE)
	openFPGALoader -b tangnano9k $<

compile:
	cd soc/testloader/ && make -f Makefile compile

flash-soft: compile
	openFPGALoader -b tangnano9k --external-flash soc/testloader/app.bin

install:
	rustup target add riscv32i-unknown-none-elf
	cargo install cargo-binutils
	rustup component add llvm-tools-preview
