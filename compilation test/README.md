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

可以看出 `vsetvli zero, zero, e32, m1, tu, mu` 尤其是其中的 `tu` 以及 `mu` 都是典型的 RVV v1.0 指令格式，所以无法从 RVV 向量扩展的方向去对 eigen 库进行优化。

当然这是针对 lpi4a，如果有能支持 RVV v1.0 的板子也可以试试。