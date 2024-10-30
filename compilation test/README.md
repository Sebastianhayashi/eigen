# 测试结果

根据以上三次测试得出结论就是怀疑是因为 lip4a 支持的是 RVV 0.7.1，而根据以下内容：

```
debian@revyos-lpi4a:~/eigen/compilation test/test-2$ objdump -d vector_test

vector_test:     file format elf64-littleriscv


Disassembly of section .text:

00000000000100b0 <_start>:
   100b0:       01007057                vsetvli zero,zero,e32,m1,tu,mu
   100b4:       8082                    ret
```

可以看出 `vsetvli zero, zero, e32, m1, tu, mu` 尤其是其中的 `tu` 以及 `mu` 都是典型的 RVV v1.0 指令格式，~~所以无法从 RVV 向量扩展的方向去对 eigen 库进行优化~~

~~当然这是针对 lpi4a，如果有能支持 RVV v1.0 的板子也可以试试~~

----

## 测试硬件支持 RVV 1.0

```
debian@revyos-lpi4a:~$ mkdir test
debian@revyos-lpi4a:~$ cd test/
debian@revyos-lpi4a:~/test$ echo "int main() { return 0; }" > test.c
debian@revyos-lpi4a:~/test$ riscv64-linux-gnu-gcc -march=rv64gcv -S -o test.s test.c
debian@revyos-lpi4a:~/test$ cat test.s
        .file   "test.c"
        .option pic
        .attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_v1p0_zicsr2p0_zifencei2p0_zve32f1p0_zve32x1p0_zve64d1p0_zve64f1p0_zve64x1p0_zvl128b1p0_zvl32b1p0_zvl64b1p0"
        .attribute unaligned_access, 0
        .attribute stack_align, 16
        .text
        .align  1
        .globl  main
        .type   main, @function
main:
.LFB0:
        .cfi_startproc
        addi    sp,sp,-16
        .cfi_def_cfa_offset 16
        sd      ra,8(sp)
        sd      s0,0(sp)
        .cfi_offset 1, -8
        .cfi_offset 8, -16
        addi    s0,sp,16
        .cfi_def_cfa 8, 0
        li      a5,0
        mv      a0,a5
        ld      ra,8(sp)
        .cfi_restore 1
        ld      s0,0(sp)
        .cfi_restore 8
        .cfi_def_cfa 2, 16
        addi    sp,sp,16
        .cfi_def_cfa_offset 0
        jr      ra
        .cfi_endproc
.LFE0:
        .size   main, .-main
        .ident  "GCC: (Debian 14.2.0-4revyos1) 14.2.0"
        .section        .note.GNU-stack,"",@progbits
```

从上面 log 可以看出，编译器设置了 v1p0 属性（.attribute arch, "rv64...v1p0..."），那就说明硬件层面可以支持 RVV1.0
可以考虑进一步让硬件支持 RVV1.0