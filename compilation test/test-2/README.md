```
debian@revyos-lpi4a:~/eigen/compilation test$ as -march=rv64gcv vector_test.s -o vector_test.o
debian@revyos-lpi4a:~/eigen/compilation test$ ld vector_test.o -o vector_test
debian@revyos-lpi4a:~/eigen/compilation test$ ./vector_test
Segmentation fault
debian@revyos-lpi4a:~/eigen/compilation test$ ls
vector_test  vector_test.o  vector_test.s
debian@revyos-lpi4a:~/eigen/compilation test$
```

结果：与 test-1 结果相同，打算进一步尝试更为简单的汇编代码