# rationale-getelementptr-replace

A LLVM IR transformation pass to mark and insert check on `getelementptr` instrustions.

the pass has to be running on `EP_ModuleOptimizerEarly`, otherwise(no mark, `early_as_possible` and `after_optimize`) will cause a random kernel corruption.

<!--LLVM transform的经验总结

pass需要标明在什么阶段，`EP_ModuleOptimizerEarly`经过测试是有效的，不标记、early_as_possible和after_optimize都会出现随机崩溃事件

上次只对ext4进行的点对点变形，一条一条指令修改，结果会造成整个内核地址混乱，虽然能运行，但是可能会崩溃，因此正确的做法是直接把pass加到make的`KCFLAGS`里面-->



## commmands

```
 2009  make CC=clang-12 O=out-all-inst/ -j16 "KCFLAGS=-Xclang -load -Xclang /home/wangzc/Desktop/experiment/rationale-getelementptr-replace/transform/libTransPass.so" 
 2010  sudo make CC=clang-12 O=out-all-inst/ -j16 "KCFLAGS=-Xclang -load -Xclang /home/wangzc/Desktop/experiment/rationale-getelementptr-replace/transform/libTransPass.so" modules_install
 2011  sudo make CC=clang-12 O=out-all-inst/ -j16 "KCFLAGS=-Xclang -load -Xclang /home/wangzc/Desktop/experiment/rationale-getelementptr-replace/transform/libTransPass.so" install
```



# getelementptr

```
  %2 = alloca %struct.s*, align 8
  %4 = load %struct.s*, %struct.s** %2, align 8
  %5 = getelementptr inbounds %struct.s, %struct.s* %4, i32 0, i32 0
  store i64 2, i64* %5, align 8

  st->a = 2;
```

