#!/bin/bash
set -e

clang -Os --target=riscv32 -march=rv32i -nostdlib -T link.ld -o firmware.elf entry.s main.c
echo ====================================
riscv64-unknown-elf-objdump -d firmware.elf
echo ====================================
riscv64-unknown-elf-objcopy -O binary firmware.elf memory.bin
xxd memory.bin

