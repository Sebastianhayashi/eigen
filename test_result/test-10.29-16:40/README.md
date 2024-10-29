该测试遵循以下流程：

```

# create a working directory
$ mkdir build
$ cd build
# create the makefiles
$ cmake /home/debian/eigen-3.3.8 \
  -DCMAKE_BUILD_TYPE=Release \
  -DEIGEN_BUILD_BTL=ON \
  -DEIGEN3_INCLUDE_DIR=/home/debian/eigen-3.3.8 \
  -DCMAKE_CXX_FLAGS="-march=rv64gc -O3 -ffast-math"
# compile the benchmarks
$ cd bench/btl
$ make -j4
# run the benchmark (on a single core)
# VERY IMPORTANT : logout, log into a console (ctrl+shift+F1) and shutdown your X server (e.g.: sudo init 3), and stop as most as services as you can
$ OMP_NUM_THREADS=4 ctest -V

```

与 test-10.29-11:06 区别在于：

- cmake 增加参数 `-DCMAKE_CXX_FLAGS="-march=rv64gc -O3 -ffast-math"`
- OMP_NUM_THREADS=1 ctest -V -> OMP_NUM_THREADS=4 ctest -V

