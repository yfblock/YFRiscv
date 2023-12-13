compile: 
	cargo build --target riscv32i-unknown-none-elf
	cargo objcopy --target riscv32i-unknown-none-elf --release -- -O binary app.bin

.PHONY: compile