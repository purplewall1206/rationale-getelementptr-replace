; ModuleID = '../src/test0-define-inst.bc'
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
  %5 = alloca i64, align 8
  %6 = ptrtoint %struct.s* %4 to i64
  %7 = call i64 @get_rand_member_offset(i64 %6, i32 1)
  store volatile i64 %7, i64* %5, align 8
  %8 = getelementptr inbounds %struct.s, %struct.s* %4, i32 0, i32 1
  store i64 2, i64* %8, align 8
  %9 = load %struct.s*, %struct.s** %2, align 8
  %10 = alloca i64, align 8
  %11 = ptrtoint %struct.s* %9 to i64
  %12 = call i64 @get_rand_member_offset(i64 %11, i32 2)
  store volatile i64 %12, i64* %10, align 8
  %13 = getelementptr inbounds %struct.s, %struct.s* %9, i32 0, i32 2
  store i32 6, i32* %13, align 8
  %14 = load %struct.s*, %struct.s** %2, align 8
  %15 = alloca i64, align 8
  %16 = ptrtoint %struct.s* %14 to i64
  %17 = call i64 @get_rand_member_offset(i64 %16, i32 3)
  store volatile i64 %17, i64* %15, align 8
  %18 = getelementptr inbounds %struct.s, %struct.s* %14, i32 0, i32 3
  store i8 97, i8* %18, align 4
  %19 = load %struct.s*, %struct.s** %2, align 8
  %20 = alloca i64, align 8
  %21 = ptrtoint %struct.s* %19 to i64
  %22 = call i64 @get_rand_member_offset(i64 %21, i32 4)
  store volatile i64 %22, i64* %20, align 8
  %23 = getelementptr inbounds %struct.s, %struct.s* %19, i32 0, i32 4
  %24 = getelementptr inbounds [10 x i8], [10 x i8]* %23, i64 0, i64 0
  store i8* %24, i8** %3, align 8
  %25 = load i8*, i8** %3, align 8
  %26 = getelementptr inbounds i8, i8* %25, i64 0
  store i8 98, i8* %26, align 1
  %27 = load i8*, i8** %3, align 8
  %28 = getelementptr inbounds i8, i8* %27, i64 1
  store i8 99, i8* %28, align 1
  %29 = load %struct.s*, %struct.s** %2, align 8
  %30 = alloca i64, align 8
  %31 = ptrtoint %struct.s* %29 to i64
  %32 = call i64 @get_rand_member_offset(i64 %31, i32 1)
  store volatile i64 %32, i64* %30, align 8
  %33 = getelementptr inbounds %struct.s, %struct.s* %29, i32 0, i32 1
  %34 = load i64, i64* %33, align 8
  ret i64 %34
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
  %9 = alloca i64, align 8
  %10 = ptrtoint %struct.s* %8 to i64
  %11 = call i64 @get_rand_member_offset(i64 %10, i32 0)
  store volatile i64 %11, i64* %9, align 8
  %12 = getelementptr inbounds %struct.s, %struct.s* %8, i32 0, i32 0
  store i64* %7, i64** %12, align 8
  %13 = load %struct.s*, %struct.s** %2, align 8
  %14 = call i64 @func(%struct.s* %13)
  store i64 %14, i64* %3, align 8
  %15 = load %struct.s*, %struct.s** %2, align 8
  %16 = alloca i64, align 8
  %17 = ptrtoint %struct.s* %15 to i64
  %18 = call i64 @get_rand_member_offset(i64 %17, i32 1)
  store volatile i64 %18, i64* %16, align 8
  %19 = getelementptr inbounds %struct.s, %struct.s* %15, i32 0, i32 1
  %20 = load i64, i64* %19, align 8
  %21 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.2, i64 0, i64 0), i64 %20)
  %22 = load %struct.s*, %struct.s** %2, align 8
  %23 = alloca i64, align 8
  %24 = ptrtoint %struct.s* %22 to i64
  %25 = call i64 @get_rand_member_offset(i64 %24, i32 2)
  store volatile i64 %25, i64* %23, align 8
  %26 = getelementptr inbounds %struct.s, %struct.s* %22, i32 0, i32 2
  %27 = load i32, i32* %26, align 8
  %28 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.3, i64 0, i64 0), i32 %27)
  %29 = load %struct.s*, %struct.s** %2, align 8
  %30 = alloca i64, align 8
  %31 = ptrtoint %struct.s* %29 to i64
  %32 = call i64 @get_rand_member_offset(i64 %31, i32 3)
  store volatile i64 %32, i64* %30, align 8
  %33 = getelementptr inbounds %struct.s, %struct.s* %29, i32 0, i32 3
  %34 = load i8, i8* %33, align 4
  %35 = sext i8 %34 to i32
  %36 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.4, i64 0, i64 0), i32 %35)
  %37 = load %struct.s*, %struct.s** %2, align 8
  %38 = alloca i64, align 8
  %39 = ptrtoint %struct.s* %37 to i64
  %40 = call i64 @get_rand_member_offset(i64 %39, i32 4)
  store volatile i64 %40, i64* %38, align 8
  %41 = getelementptr inbounds %struct.s, %struct.s* %37, i32 0, i32 4
  %42 = getelementptr inbounds [10 x i8], [10 x i8]* %41, i64 0, i64 2
  store i8 100, i8* %42, align 1
  %43 = load %struct.s*, %struct.s** %2, align 8
  %44 = alloca i64, align 8
  %45 = ptrtoint %struct.s* %43 to i64
  %46 = call i64 @get_rand_member_offset(i64 %45, i32 4)
  store volatile i64 %46, i64* %44, align 8
  %47 = getelementptr inbounds %struct.s, %struct.s* %43, i32 0, i32 4
  %48 = getelementptr inbounds [10 x i8], [10 x i8]* %47, i64 0, i64 3
  store i8 101, i8* %48, align 1
  %49 = load %struct.s*, %struct.s** %2, align 8
  store %struct.s* %49, %struct.s** %4, align 8
  %50 = load %struct.s*, %struct.s** %4, align 8
  %51 = bitcast %struct.s* %50 to i8*
  call void @free(i8* %51) #3
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
