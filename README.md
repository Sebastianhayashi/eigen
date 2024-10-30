# eigen

## 优化思路

### 从 RVV 出发

~~可以考虑使用 RVV 提高向量库的运行效率~~

根据该[优化后的编译器](https://github.com/sipeed/sipeed_wiki/blob/main/docs/hardware/zh/lichee/th1520/lpi4a/8_application.md#%E4%BD%BF%E7%94%A8%E4%BC%98%E5%8C%96-gcc-%E5%B7%A5%E5%85%B7%E9%93%BE)，以及以下 cmake 配置：

```
cmake /home/debian/eigen-3.3.8 \
  -DCMAKE_BUILD_TYPE=Release \
  -DEIGEN_BUILD_BTL=ON \
  -DEIGEN3_INCLUDE_DIR=/home/debian/eigen-3.3.8 \
  -DCMAKE_CXX_FLAGS="-march=rv64gcv -mabi=lp64d -O3 -mcmodel=medany -fno-common -funroll-loops -finline-functions -finline-limit=1000 -fno-if-conversion2 -fselective-scheduling -fno-crossjumping -freorder-blocks-and-partition -falign-functions=8 -falign-jumps=8 -falign-loops=8"
```

结果：
- 第一次：`1/8 Test #1: btl_eigen3_linear ................   Passed  328.36 sec`
- 第二次：`1/8 Test #1: btl_eigen3_linear ................   Passed  332.15 sec`

相较于未开启 `-march=rv64gcv` 慢了约 30 sec:
- 未开启：`1/8 Test #1: btl_eigen3_linear ................   Passed  300.68 sec`

考虑到可能使用过于复杂的参数，进一步的使用简化参数配置：

```
cmake /home/debian/eigen-3.3.8 \
  -DCMAKE_BUILD_TYPE=Release \
  -DEIGEN_BUILD_BTL=ON \
  -DEIGEN3_INCLUDE_DIR=/home/debian/eigen-3.3.8 \
  -DCMAKE_CXX_FLAGS="-march=rv64gcv -mabi=lp64d -O3 -mcmodel=medany -ffast-math"
```

结果：
- `1/8 Test #1: btl_eigen3_linear ................   Passed  300.54 sec`

结论：与未开启 `-march=rv64gcv` 近乎相同。

### 从其他已经优化好的库出发

使用已经优化好的库，如：https://github.com/HellerZheng/eigen    