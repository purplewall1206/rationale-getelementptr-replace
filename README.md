# rationale-getelementptr-replace

1. transformation
2. src


# getelementptr

```
    %4 = load %struct.s*, %struct.s** %2, align 8
  %5 = getelementptr inbounds %struct.s, %struct.s* %4, i32 0, i32 0
  store i64 2, i64* %5, align 8
```