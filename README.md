# rationale-getelementptr-replace

1. transformation
2. src


- 实现简单的getelemetptr替换
- llvm-ir编译kernel，llc修改kernel object最后链接
- 研究下rcu和cred
- 看看实验，选择哪些
- 相关工作复现
- ebpf脚本
- ebpf helper function

# getelementptr

```
  %2 = alloca %struct.s*, align 8
  %4 = load %struct.s*, %struct.s** %2, align 8
  %5 = getelementptr inbounds %struct.s, %struct.s* %4, i32 0, i32 0
  store i64 2, i64* %5, align 8

  st->a = 2;
```