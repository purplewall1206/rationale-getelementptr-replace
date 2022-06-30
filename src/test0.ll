; ModuleID = 'test0.c'
source_filename = "test0.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.s = type { i64, i32, i8, [10 x i8] }

@.str = private unnamed_addr constant [11 x i8] c"x->a: %lu\0A\00", align 1
@.str.1 = private unnamed_addr constant [10 x i8] c"x->b: %d\0A\00", align 1
@.str.2 = private unnamed_addr constant [10 x i8] c"x->c: %c\0A\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @func(%struct.s* %0) #0 {
  %2 = alloca %struct.s*, align 8
  %3 = alloca i8*, align 8
  store %struct.s* %0, %struct.s** %2, align 8
  %4 = load %struct.s*, %struct.s** %2, align 8
  %5 = getelementptr inbounds %struct.s, %struct.s* %4, i32 0, i32 0
  store i64 2, i64* %5, align 8
  %6 = load %struct.s*, %struct.s** %2, align 8
  %7 = getelementptr inbounds %struct.s, %struct.s* %6, i32 0, i32 1
  store i32 6, i32* %7, align 8
  %8 = load %struct.s*, %struct.s** %2, align 8
  %9 = getelementptr inbounds %struct.s, %struct.s* %8, i32 0, i32 2
  store i8 97, i8* %9, align 4
  %10 = load %struct.s*, %struct.s** %2, align 8
  %11 = getelementptr inbounds %struct.s, %struct.s* %10, i32 0, i32 3
  %12 = getelementptr inbounds [10 x i8], [10 x i8]* %11, i64 0, i64 0
  store i8* %12, i8** %3, align 8
  %13 = load i8*, i8** %3, align 8
  %14 = getelementptr inbounds i8, i8* %13, i64 0
  store i8 98, i8* %14, align 1
  %15 = load i8*, i8** %3, align 8
  %16 = getelementptr inbounds i8, i8* %15, i64 1
  store i8 99, i8* %16, align 1
  %17 = load %struct.s*, %struct.s** %2, align 8
  %18 = getelementptr inbounds %struct.s, %struct.s* %17, i32 0, i32 0
  %19 = load i64, i64* %18, align 8
  ret i64 %19
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca %struct.s*, align 8
  %3 = alloca i64, align 8
  %4 = alloca %struct.s*, align 8
  store i32 0, i32* %1, align 4
  %5 = call noalias align 16 i8* @malloc(i64 24) #3
  %6 = bitcast i8* %5 to %struct.s*
  store %struct.s* %6, %struct.s** %2, align 8
  %7 = load %struct.s*, %struct.s** %2, align 8
  %8 = call i64 @func(%struct.s* %7)
  store i64 %8, i64* %3, align 8
  %9 = load %struct.s*, %struct.s** %2, align 8
  %10 = getelementptr inbounds %struct.s, %struct.s* %9, i32 0, i32 0
  %11 = load i64, i64* %10, align 8
  %12 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i64 0, i64 0), i64 %11)
  %13 = load %struct.s*, %struct.s** %2, align 8
  %14 = getelementptr inbounds %struct.s, %struct.s* %13, i32 0, i32 1
  %15 = load i32, i32* %14, align 8
  %16 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.1, i64 0, i64 0), i32 %15)
  %17 = load %struct.s*, %struct.s** %2, align 8
  %18 = getelementptr inbounds %struct.s, %struct.s* %17, i32 0, i32 2
  %19 = load i8, i8* %18, align 4
  %20 = sext i8 %19 to i32
  %21 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.2, i64 0, i64 0), i32 %20)
  %22 = load %struct.s*, %struct.s** %2, align 8
  %23 = getelementptr inbounds %struct.s, %struct.s* %22, i32 0, i32 3
  %24 = getelementptr inbounds [10 x i8], [10 x i8]* %23, i64 0, i64 2
  store i8 100, i8* %24, align 1
  %25 = load %struct.s*, %struct.s** %2, align 8
  %26 = getelementptr inbounds %struct.s, %struct.s* %25, i32 0, i32 3
  %27 = getelementptr inbounds [10 x i8], [10 x i8]* %26, i64 0, i64 3
  store i8 101, i8* %27, align 1
  %28 = load %struct.s*, %struct.s** %2, align 8
  store %struct.s* %28, %struct.s** %4, align 8
  %29 = load %struct.s*, %struct.s** %4, align 8
  %30 = bitcast %struct.s* %29 to i8*
  call void @free(i8* %30) #3
  ret i32 0
}

; Function Attrs: nounwind
declare dso_local noalias align 16 i8* @malloc(i64) #1

declare dso_local i32 @printf(i8*, ...) #2

; Function Attrs: nounwind
declare dso_local void @free(i8*) #1

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nounwind }

!llvm.module.flags = !{!0, !1, !2}
!llvm.ident = !{!3}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"uwtable", i32 1}
!2 = !{i32 7, !"frame-pointer", i32 2}
!3 = !{!"Ubuntu clang version 13.0.0-2"}
