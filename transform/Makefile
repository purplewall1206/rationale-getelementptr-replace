inst:
	clang-12 `llvm-config --cxxflags` -Wl,-znodelete -fno-rtti -fPIC -shared ./TransPass.cpp -o libTransPass.so `llvm-config --ldflags`

opt:
	clang-12 -DERA_S=1 -emit-llvm -S ../src/test0.c -o ../src/test0-define.ll
	opt-12 -load ./libTransPass.so -inst ../src/test0-define.ll -o ../src/test0-define-inst.bc
	llvm-dis-12 ../src/test0-define-inst.bc -o ../src/test0-define-inst.ll
	llc-12 --filetype=obj ../src/test0-define-inst.bc -o ../src/test0-define-inst.o
	gcc ../src/test0-define-inst.o -o ../src/test0-define-inst
	../src/test0-define-inst