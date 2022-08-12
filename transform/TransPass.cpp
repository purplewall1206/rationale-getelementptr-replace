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


#include "llvm/Transforms/Utils/Cloning.h"

#include <vector>
#include <unordered_set>
#include <regex>

using namespace llvm;

namespace {
    struct Inst0ModulePass : public ModulePass {
        static char ID;
        int instructionsCount = 0;
        Inst0ModulePass() : ModulePass(ID) {}
        bool runOnModule(Module &M) override;
        // std::vector<Instruction*> storeVec;
        // std::vector<Instruction*> entryVec;
        std::vector<Instruction*> getelemVec;
        // std::vector<std::string> matches = {"%struct.kernfs_open_file"};
        // std::vector<std::string> matches = {"%struct.seq_operations"};
        std::vector<std::string> matches = {"%struct.kernfs_open_file", "%struct.seq_operations"};
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
        // outs() << "instructions : " << M.getInstructionCount() << "\n";
        // instructionsCount = M.getInstructionCount();
        for (auto& F : M) {
            // 需要排除掉需要插装的函数
            if (F.getName() == "get_rand_member_offset" || F.getName() == "f_n_y_shuffle") {
                // outs() << F.getName() << "========removed\n";
                continue;
            } else {
                // outs() << F.getName() << "\n";
            }
            
            for (auto& BB : F) {
                for (auto& Ins : BB) {
                    // 如果编译的时候带着debug info，那么没有metadata/debuginfo 的函数不能插装
                    // inlinable function call in a function with debug info must have a !dbg location
                    // if (!Ins.hasMetadata()) {
                    //     continue;
                    // }
                    if (Ins.getOpcode() == Instruction::GetElementPtr) {
                        GetElementPtrInst *gi = dyn_cast<GetElementPtrInst>(&Ins);
                        std::string type_str;
						raw_string_ostream rso(type_str);
						gi->getSourceElementType()->print(rso);
                        
                        if (isMatched(type_str)) {
                            // outs() << "\t" << Ins << "\n";
                            // outs() << "\t\t" << Ins << gi->getPointerOperand() << "\n";
                            // for (auto &x : gi->operands()) {
                            //     outs() << "\t\t" << *x << "\n";
                            // }
                            getelemVec.push_back(&Ins);
                        }
                    }
                }
            }
        }

        // 插桩
        // if (!getelemVec.empty()) {
        //     // get function  void print(unsigned long x) {
        //     Type *voidty = Type::getVoidTy(CTX);
        //     Type *intTy64 = Type::getInt64Ty(CTX);
        //     bool isVarArg = false;
        //     std::vector<Type*> funcParam;
        //     funcParam.push_back(intTy64);
        //     FunctionType *functionCallType = FunctionType::get(
        //         voidty, funcParam, isVarArg 
        //     );
        //     M.getOrInsertFunction("print", functionCallType);
        //     Function* printFunc = M.getFunction("print");
        //     // outs() << "get function0: print at " << printFunc << "\n";

        //     for (auto &Ins : getelemVec) {
        //         auto param0 = Ins->getOperand(0);
        //         auto param1 = Ins->getOperand(1);
        //         auto param2 = Ins->getOperand(2);
        //         // outs() << param0 << ":" << *param1 << ":" << *param2 << "\n";
        //         IRBuilder<> builder(Ins);
        //         builder.CreateCall(printFunc, {builder.CreateIntCast(param1, Type::getInt64Ty(CTX), true)});
        //         builder.CreateCall(printFunc, {builder.CreateIntCast(param2, Type::getInt64Ty(CTX), true)});
        //         // outs() << " ??? " << "\n";
        //         // auto pp1 = builder.CreateIntCast(param1, Type::getInt64Ty(CTX), true);
        //         // outs() << "debug " << *pp1 << "\n";
        //         // builder.CreateCall(printFunc, {pp1});
        //         // builder.CreateCall(printFunc, {builder.CreateIntCast(param1, Type::getInt64Ty(CTX))});
        //         builder.CreateCall(printFunc, {builder.CreatePtrToInt(param0, Type::getInt64Ty(CTX))});

        //     }
        // }

        if (!getelemVec.empty()) {
            Type *intTy64 = Type::getInt64Ty(CTX);
            Type *intTy32 = Type::getInt32Ty(CTX);
            bool isVarArg = false;
            // define dso_local i64 @get_rand_member_offset(i64 %0, i32 %1) #0 {
            std::vector<Type*> funcParam = {intTy64, intTy32};
            FunctionType *functionCallType = FunctionType::get(
                intTy64, funcParam, isVarArg 
            );
            M.getOrInsertFunction("get_rand_member_offset", functionCallType);
            Function* get_rand_member_offset_Func = M.getFunction("get_rand_member_offset");
            if (get_rand_member_offset_Func == nullptr) {
                outs() << "do not get get_rand_member_offset\n";
                return false;
            }

            for (auto &Ins : getelemVec) {
                IRBuilder<> builder(Ins);
                auto param0 = Ins->getOperand(0);
                auto param2 = Ins->getOperand(2);
                AllocaInst *stackVar = builder.CreateAlloca(Type::getInt64Ty(CTX), nullptr, "rand_offset");
                auto rand_offset = builder.CreateCall(get_rand_member_offset_Func, {builder.CreatePtrToInt(param0, Type::getInt64Ty(CTX)), param2});
                Value *res = dyn_cast<Value>(rand_offset);
                Value *dst = dyn_cast<Value>(stackVar);
                // outs() << "\t\t" << res << ":" << dst << "\n";
                builder.CreateStore(res, dst, true);
                // builder.CreateLoad(rand_offset, "rand_offset");
            }
        }

        outs() << "replace " << getelemVec.size() << " getelementptrs\n";
        
        
        return true;
    }

    


    char Inst0ModulePass::ID = 0;
    RegisterPass<Inst0ModulePass> 
        X (/*PassArg=*/"inst",
        /*Name=*/"Inst0ModulePass",
        /*CFGOnly=*/true,
        /*is_analysis=*/true);
}