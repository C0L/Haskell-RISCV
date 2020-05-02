# Haskall-RISCV
This is a simplistic C to RISCV compiler writen in Haskell. Currently it only impliments a restricted subset of C code, with the hope to eventually be a general compiler. This only acts as a translator to assembly, so currently the linking and assembler is being left to gcc.

## Building
This project uses `stack` to manage the project repository, which provides a consistent build environment on across machines. To build the project from within the directory simply run:

`stack build`

Then to move the executable to an accessible direction we run:

`stack install`

This should put Haskell-RISCV-exe into a directory like `/home/colin/.local/bin`. The executable can then be run on a simple test c program by running:

`Haskell-RISCV-exe < test/test.c`

If the executable directory has nor been added to your path before it will not be found and need to run:

`export PATH=$PATH:"/home/colin/.local/bin"`

This results in the following:

[TODO] add example prog output

## Testing

The outputted assembly from the above program can be added to its own file. For this example I will call this file test.s.

We need to convert this into bytecode before we can run it on any RISCV processor. I am using the riscv64 Newlib toolchain for the linking and assembly.

In order to convert our generated assembly into bytecode we run:

`riscv64-unknown-elf-gcc test.s -o test.o`

Now test.o is the generated RISCV bytecode we wish to run on a RISCV processor. Because this is not running on baremetal, the newlib compiler will add a proxy kernal around our generated code. 

I will be testing the code on the spike simulator with the pk proxy kernal. I have not found a better way to track the execution of my genrated programs than the following:

To find where main method starts we run:

`riscv64-unknown-elf-objdump -d test.o | less`

```
000000000001014a <main>:
   1014a:       1141                    addi    sp,sp,-16
   1014c:       e422                    sd      s0,8(sp)
   1014e:       0800                    addi    s0,sp,16
   10150:       4785                    li      a5,1
   10152:       853e                    mv      a0,a5
   10154:       6422                    ld      s0,8(sp)
   10156:       0141                    addi    sp,sp,16
   10158:       8082                    ret
```

This means that at pc = 0x000000000001014a our code will actual begin. This simple program just returns 1.

Then with spike we can simulate this point with the following:

`spike -d /opt/riscv/bin/riscv64-unknown-elf/bin/pk test.o`

Running `until pc 0 0x000000000001014a` will move to the start of the main method. And pressing enter will iterate through our instructions. 

Once reached the end we can see what value is in the return address by running `reg 0 a0`

[TODO] Complete

## Implimentation Details
