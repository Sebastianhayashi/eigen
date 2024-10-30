```
debian@revyos-lpi4a:~/eigen/compilation test$ as -march=rv64gcv vector_test.s -o vector_test.o
debian@revyos-lpi4a:~/eigen/compilation test$ ld vector_test.o -o vector_test
debian@revyos-lpi4a:~/eigen/compilation test$ ./vector_test
Segmentation fault
debian@revyos-lpi4a:~/eigen/compilation test$ ls
vector_test  vector_test.o  vector_test.s
```

结果：向量扩展可能不完全兼容，也可能是测试代码不符合规范