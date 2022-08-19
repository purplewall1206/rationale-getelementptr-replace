#include "llvm/ADT/MapVector.h"
#include "llvm/IR/AbstractCallSite.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/PassManager.h"
#include "llvm/IR/Type.h"
#include "llvm/Pass.h"
#include "llvm/Support/raw_ostream.h"

#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/InlineAsm.h"

#include "llvm/Pass.h"
#include "llvm/IR/Constants.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/Value.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/Instruction.h"
#include "llvm/IR/Instructions.h"
#include "llvm/Support/raw_ostream.h"

#include "llvm/IR/LegacyPassManager.h"
#include "llvm/Transforms/IPO/PassManagerBuilder.h"


#include "llvm/Transforms/Utils/Cloning.h"

#include <vector>
#include <unordered_set>
#include <regex>
#include <iostream>

// make "KCFLAGS=-pipe -Wsomething"

using namespace llvm;

namespace {
    struct Inst0ModulePass : public ModulePass {
        static char ID;
        int instructionsCount = 0;
        Inst0ModulePass() : ModulePass(ID) {}
        bool runOnModule(Module &M) override;
        std::vector<Instruction*> getelemVec;
        // std::vector<std::string> matches = {"%struct.kernfs_open_file"};
        // std::vector<std::string> matches = {"%struct.seq_operations"};
        std::vector<std::string> matches = {"%struct.kernfs_open_file = ", "%struct.seq_operations = "};
        // std::vector<std::string> matches = {"%struct.s"};
        bool isMatched(std::string type);
    };

    bool Inst0ModulePass::isMatched(std::string type)
    {
        bool res = false;
        for (auto &s : matches) {
            if (type.find(s) != std::string::npos) {
                return true;
            }
        }
        return false;
    }

    bool Inst0ModulePass::runOnModule(Module &M)  {
        auto& CTX = M.getContext();
        
        for (auto& F : M) {
            // 需要排除掉需要插装的函数
            if (F.getName() == "get_rand_member_offset" || F.getName() == "f_n_y_shuffle") {
                continue;
            } else {
                // outs() << F.getName() << "\n";
            }
            
            for (auto& BB : F) {
                AllocaInst *stackVar;
                bool flag = false;
                for (auto& Ins : BB) {
                    // 如果编译的时候带着debug info，那么没有metadata/debuginfo 的函数不能插装
                    // inlinable function call in a function with debug info must have a !dbg location
                    // if (!Ins.hasMetadata()) {
                    //     continue;
                    // }
                    if (Ins.getOpcode() == Instruction::GetElementPtr) {
                        // outs() << "---------------\n"; 
                        GetElementPtrInst *gi = dyn_cast<GetElementPtrInst>(&Ins);
                        std::string type_str;
						raw_string_ostream rso(type_str);
						gi->getSourceElementType()->print(rso);
                        // outs() << "---------------0\n"; 
                        if (isMatched(type_str)) {
                            // outs() << "---------------1\n"; 
                            outs() << "\t\t\t" << Ins << "\n";
                            // std::cout << "\t\t" << type_str << "\n";
                            Type *intTy64 = Type::getInt64Ty(CTX);
                            Type *int64Ptr = Type::getInt64PtrTy(CTX);
                            Type *intTy32 = Type::getInt32Ty(CTX);
                            bool isVarArg = false;
                            // define dso_local i64 @get_rand_member_offset(i64 %0, i32 %1) #0 {
                            // define dso_local i64 @get_rand_member_offset(i64* %0, i32 %1)
                            // std::vector<Type*> funcParam = {intTy64, intTy32};
                            std::vector<Type*> funcParam = {int64Ptr, intTy32};
                            FunctionType *functionCallType = FunctionType::get(
                                intTy64, funcParam, isVarArg 
                            );
                            // outs() << "---------------2\n"; 
                            M.getOrInsertFunction("get_rand_member_offset", functionCallType);
                            Function* get_rand_member_offset_Func = M.getFunction("get_rand_member_offset");
                            if (get_rand_member_offset_Func == nullptr) {
                                outs() << "do not get get_rand_member_offset\n";
                                return false;
                            }

// outs() << "---------------3\n"; 
                            int count_wrong_ins = 0;
                            // for (auto &Ins : getelemVec) {
                                IRBuilder<> builder(&Ins);
                                if (Ins.getNumOperands() < 3) {
                                    outs() << "\t\t\t wrong ins: " << Ins << ++count_wrong_ins << "\n";

                                    continue;
                                }
                                // outs() << "---------------4\n"; 
                                auto param0 = Ins.getOperand(0);
                                auto param2 = Ins.getOperand(2);
                                if (param0 == nullptr || param2 == nullptr) {
                                    continue;
                                }
                                // outs() << "---------------5\n"; 
                                if (flag == false) {
                                    stackVar = builder.CreateAlloca(Type::getInt64Ty(CTX), nullptr, "rand_offset");
                                    flag = true;
                                }
                                // AllocaInst *stackVar = builder.CreateAlloca(Type::getInt64Ty(CTX), nullptr, "rand_offset");
                                // outs() << "---------------5.1\n"; 
                                // for (int i = 0;i < 100000000;i++) {
                                //     // maybe we need wait a second here ?
                                // }
                                // auto tmp1 = builder.CreatePtrToInt(param0, Type::getInt64PtrTy(CTX));
                                auto tmp1 = builder.CreateBitOrPointerCast(param0, Type::getInt64PtrTy(CTX));
                                
                                // outs() << "---------------5.2\n"; 
                                // for (int i = 0;i < 100000000;i++) {
                                //     // maybe we need wait a second here ?
                                // }
                                auto rand_offset = builder.CreateCall(get_rand_member_offset_Func, {tmp1, param2});
                                // outs() << "---------------5.3\n"; 

                                Value *res = dyn_cast<Value>(rand_offset);
                                Value *dst = dyn_cast<Value>(stackVar);
                                // outs() << "---------------6\n"; 
                                if (res == nullptr || dst == nullptr) {
                                    continue;
                                }
                                // outs() << "\t\t" << res << ":" << dst << "\n";
                                // builder.CreateStore(res, dst, true);
                                // builder.CreateLoad(rand_offset, "rand_offset");
                            // }
                            getelemVec.push_back(&Ins);
                        }
                    }
                }
            }
        }


        outs() << "replaced " << getelemVec.size() << " getelementptrs\n";
        
        
        return true;
    }

    


    char Inst0ModulePass::ID = 0;
    RegisterPass<Inst0ModulePass> 
        X (/*PassArg=*/"inst",
        /*Name=*/"Inst0ModulePass",
        /*CFGOnly=*/true,
        /*is_analysis=*/true);
    static RegisterStandardPasses Y(
    PassManagerBuilder::EP_ModuleOptimizerEarly,
    [](const PassManagerBuilder &Builder,
       legacy::PassManagerBase &PM) { PM.add(new Inst0ModulePass()); });
}