; ModuleID = '../src/test0.c'
source_filename = "../src/test0.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.s = type { i64*, i64, i32, i8, [10 x i8] }

@.str = private unnamed_addr constant [18 x i8] c"\09\09output: %016lx\0A\00", align 1
@.str.1 = private unnamed_addr constant [16 x i8] c"output: %016lx\0A\00", align 1
@.str.2 = private unnamed_addr constant [11 x i8] c"x->a: %lu\0A\00", align 1
@.str.3 = private unnamed_addr constant [10 x i8] c"x->b: %d\0A\00", align 1
@.str.4 = private unnamed_addr constant [10 x i8] c"x->c: %c\0A\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @func(%struct.s* %0) #0 {
  %2 = alloca %struct.s*, align 8
  %3 = alloca i8*, align 8
  store %struct.s* %0, %struct.s** %2, align 8
  %4 = load %struct.s*, %struct.s** %2, align 8
  %5 = getelementptr inbounds %struct.s, %struct.s* %4, i32 0, i32 1
  store i64 2, i64* %5, align 8
  %6 = load %struct.s*, %struct.s** %2, align 8
  %7 = getelementptr inbounds %struct.s, %struct.s* %6, i32 0, i32 2
  store i32 6, i32* %7, align 8
  %8 = load %struct.s*, %struct.s** %2, align 8
  %9 = getelementptr inbounds %struct.s, %struct.s* %8, i32 0, i32 3
  store i8 97, i8* %9, align 4
  %10 = load %struct.s*, %struct.s** %2, align 8
  %11 = getelementptr inbounds %struct.s, %struct.s* %10, i32 0, i32 4
  %12 = getelementptr inbounds [10 x i8], [10 x i8]* %11, i64 0, i64 0
  store i8* %12, i8** %3, align 8
  %13 = load i8*, i8** %3, align 8
  %14 = getelementptr inbounds i8, i8* %13, i64 0
  store i8 98, i8* %14, align 1
  %15 = load i8*, i8** %3, align 8
  %16 = getelementptr inbounds i8, i8* %15, i64 1
  store i8 99, i8* %16, align 1
  %17 = load %struct.s*, %struct.s** %2, align 8
  %18 = getelementptr inbounds %struct.s, %struct.s* %17, i32 0, i32 1
  %19 = load i64, i64* %18, align 8
  ret i64 %19
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64* @f_n_y_shuffle(i32 %0, i32 %1, i32 %2) #0 {
  %4 = alloca i64*, align 8
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i64*, align 8
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  store i32 %0, i32* %5, align 4
  store i32 %1, i32* %6, align 4
  store i32 %2, i32* %7, align 4
  %13 = load i32, i32* %7, align 4
  %14 = load i32, i32* %5, align 4
  %15 = icmp sgt i32 %13, %14
  br i1 %15, label %20, label %16

16:                                               ; preds = %3
  %17 = load i32, i32* %6, align 4
  %18 = load i32, i32* %7, align 4
  %19 = icmp sge i32 %17, %18
  br i1 %19, label %20, label %21

20:                                               ; preds = %16, %3
  store i64* null, i64** %4, align 8
  br label %88

21:                                               ; preds = %16
  %22 = load i32, i32* %5, align 4
  %23 = sext i32 %22 to i64
  %24 = mul i64 %23, 8
  %25 = call noalias i8* @malloc(i64 %24) #3
  %26 = bitcast i8* %25 to i64*
  store i64* %26, i64** %8, align 8
  store i32 0, i32* %9, align 4
  br label %27

27:                                               ; preds = %39, %21
  %28 = load i32, i32* %9, align 4
  %29 = load i32, i32* %5, align 4
  %30 = icmp slt i32 %28, %29
  br i1 %30, label %31, label %42

31:                                               ; preds = %27
  %32 = load i32, i32* %9, align 4
  %33 = mul nsw i32 %32, 8
  %34 = sext i32 %33 to i64
  %35 = load i64*, i64** %8, align 8
  %36 = load i32, i32* %9, align 4
  %37 = sext i32 %36 to i64
  %38 = getelementptr inbounds i64, i64* %35, i64 %37
  store i64 %34, i64* %38, align 8
  br label %39

39:                                               ; preds = %31
  %40 = load i32, i32* %9, align 4
  %41 = add nsw i32 %40, 1
  store i32 %41, i32* %9, align 4
  br label %27, !llvm.loop !2

42:                                               ; preds = %27
  %43 = load i32, i32* %6, align 4
  store i32 %43, i32* %10, align 4
  br label %44

44:                                               ; preds = %83, %42
  %45 = load i32, i32* %10, align 4
  %46 = load i32, i32* %7, align 4
  %47 = icmp slt i32 %45, %46
  br i1 %47, label %48, label %86

48:                                               ; preds = %44
  %49 = call i32 @rand() #3
  %50 = load i32, i32* %7, align 4
  %51 = load i32, i32* %6, align 4
  %52 = sub nsw i32 %50, %51
  %53 = add nsw i32 %52, 1
  %54 = srem i32 %49, %53
  %55 = load i32, i32* %6, align 4
  %56 = add nsw i32 %54, %55
  store i32 %56, i32* %11, align 4
  %57 = load i32, i32* %11, align 4
  %58 = load i32, i32* %10, align 4
  %59 = icmp ne i32 %57, %58
  br i1 %59, label %60, label %82

60:                                               ; preds = %48
  %61 = load i64*, i64** %8, align 8
  %62 = load i32, i32* %10, align 4
  %63 = sext i32 %62 to i64
  %64 = getelementptr inbounds i64, i64* %61, i64 %63
  %65 = load i64, i64* %64, align 8
  %66 = trunc i64 %65 to i32
  store i32 %66, i32* %12, align 4
  %67 = load i64*, i64** %8, align 8
  %68 = load i32, i32* %11, align 4
  %69 = sext i32 %68 to i64
  %70 = getelementptr inbounds i64, i64* %67, i64 %69
  %71 = load i64, i64* %70, align 8
  %72 = load i64*, i64** %8, align 8
  %73 = load i32, i32* %10, align 4
  %74 = sext i32 %73 to i64
  %75 = getelementptr inbounds i64, i64* %72, i64 %74
  store i64 %71, i64* %75, align 8
  %76 = load i32, i32* %12, align 4
  %77 = sext i32 %76 to i64
  %78 = load i64*, i64** %8, align 8
  %79 = load i32, i32* %11, align 4
  %80 = sext i32 %79 to i64
  %81 = getelementptr inbounds i64, i64* %78, i64 %80
  store i64 %77, i64* %81, align 8
  br label %82

82:                                               ; preds = %60, %48
  br label %83

83:                                               ; preds = %82
  %84 = load i32, i32* %10, align 4
  %85 = add nsw i32 %84, 1
  store i32 %85, i32* %10, align 4
  br label %44, !llvm.loop !4

86:                                               ; preds = %44
  %87 = load i64*, i64** %8, align 8
  store i64* %87, i64** %4, align 8
  br label %88

88:                                               ; preds = %86, %20
  %89 = load i64*, i64** %4, align 8
  ret i64* %89
}

; Function Attrs: nounwind
declare dso_local noalias i8* @malloc(i64) #1

; Function Attrs: nounwind
declare dso_local i32 @rand() #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @get_rand_member_offset(i64 %0, i32 %1) #0 {
  %3 = alloca i64, align 8
  %4 = alloca i32, align 4
  %5 = alloca i64*, align 8
  store i64 %0, i64* %3, align 8
  store i32 %1, i32* %4, align 4
  %6 = load i64, i64* %3, align 8
  %7 = inttoptr i64 %6 to i64*
  store i64* %7, i64** %5, align 8
  %8 = load i64*, i64** %5, align 8
  %9 = load i32, i32* %4, align 4
  %10 = sext i32 %9 to i64
  %11 = getelementptr inbounds i64, i64* %8, i64 %10
  %12 = load i64, i64* %11, align 8
  %13 = load i64, i64* %3, align 8
  %14 = add i64 %12, %13
  %15 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str, i64 0, i64 0), i64 %14)
  %16 = load i64*, i64** %5, align 8
  %17 = load i32, i32* %4, align 4
  %18 = sext i32 %17 to i64
  %19 = getelementptr inbounds i64, i64* %16, i64 %18
  %20 = load i64, i64* %19, align 8
  %21 = load i64, i64* %3, align 8
  %22 = add i64 %20, %21
  ret i64 %22
}

declare dso_local i32 @printf(i8*, ...) #2

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @print(i64 %0) #0 {
  %2 = alloca i64, align 8
  store i64 %0, i64* %2, align 8
  %3 = load i64, i64* %2, align 8
  %4 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.1, i64 0, i64 0), i64 %3)
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca %struct.s*, align 8
  %3 = alloca i64, align 8
  %4 = alloca %struct.s*, align 8
  store i32 0, i32* %1, align 4
  %5 = call noalias i8* @malloc(i64 32) #3
  %6 = bitcast i8* %5 to %struct.s*
  store %struct.s* %6, %struct.s** %2, align 8
  %7 = call i64* @f_n_y_shuffle(i32 5, i32 1, i32 3)
  %8 = load %struct.s*, %struct.s** %2, align 8
  %9 = getelementptr inbounds %struct.s, %struct.s* %8, i32 0, i32 0
  store i64* %7, i64** %9, align 8
  %10 = load %struct.s*, %struct.s** %2, align 8
  %11 = call i64 @func(%struct.s* %10)
  store i64 %11, i64* %3, align 8
  %12 = load %struct.s*, %struct.s** %2, align 8
  %13 = getelementptr inbounds %struct.s, %struct.s* %12, i32 0, i32 1
  %14 = load i64, i64* %13, align 8
  %15 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.2, i64 0, i64 0), i64 %14)
  %16 = load %struct.s*, %struct.s** %2, align 8
  %17 = getelementptr inbounds %struct.s, %struct.s* %16, i32 0, i32 2
  %18 = load i32, i32* %17, align 8
  %19 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.3, i64 0, i64 0), i32 %18)
  %20 = load %struct.s*, %struct.s** %2, align 8
  %21 = getelementptr inbounds %struct.s, %struct.s* %20, i32 0, i32 3
  %22 = load i8, i8* %21, align 4
  %23 = sext i8 %22 to i32
  %24 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.4, i64 0, i64 0), i32 %23)
  %25 = load %struct.s*, %struct.s** %2, align 8
  %26 = getelementptr inbounds %struct.s, %struct.s* %25, i32 0, i32 4
  %27 = getelementptr inbounds [10 x i8], [10 x i8]* %26, i64 0, i64 2
  store i8 100, i8* %27, align 1
  %28 = load %struct.s*, %struct.s** %2, align 8
  %29 = getelementptr inbounds %struct.s, %struct.s* %28, i32 0, i32 4
  %30 = getelementptr inbounds [10 x i8], [10 x i8]* %29, i64 0, i64 3
  store i8 101, i8* %30, align 1
  %31 = load %struct.s*, %struct.s** %2, align 8
  store %struct.s* %31, %struct.s** %4, align 8
  %32 = load %struct.s*, %struct.s** %4, align 8
  %33 = bitcast %struct.s* %32 to i8*
  call void @free(i8* %33) #3
  ret i32 0
}

; Function Attrs: nounwind
declare dso_local void @free(i8*) #1

attributes #0 = { noinline nounwind optnone uwtable "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"Ubuntu clang version 12.0.1-8build1"}
!2 = distinct !{!2, !3}
!3 = !{!"llvm.loop.mustprogress"}
!4 = distinct !{!4, !3}
