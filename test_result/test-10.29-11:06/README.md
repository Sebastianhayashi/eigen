依照以下过程进行测试：

```
# create a working directory
$ mkdir build
$ cd build
# create the makefiles
$ cmake <path_to_eigen_source> -DCMAKE_BUILD_TYPE=Release -DEIGEN_BUILD_BTL=ON -DEIGEN3_INCLUDE_DIR=<path_to_eigen_source>
# compile the benchmarks
$ cd bench/btl
$ make -j4
# run the benchmark (on a single core)
# VERY IMPORTANT : logout, log into a console (ctrl+shift+F1) and shutdown your X server (e.g.: sudo init 3), and stop as most as services as you can
$ OMP_NUM_THREADS=1 ctest -V
```

从 11：06 测试到 16:19 大约五小时，跑完七个批次