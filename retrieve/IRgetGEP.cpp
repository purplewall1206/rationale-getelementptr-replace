#include "llvm/ADT/MapVector.h"
// #include "llvm/IR/AbstractCallSite.h"
#include "llvm/IR/PassManager.h"

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
#include "llvm/IR/ValueSymbolTable.h"

#include "llvm/IR/LegacyPassManager.h"
#include "llvm/Transforms/IPO/PassManagerBuilder.h"
// #include "allocations.h"

#include <sqlite3.h>
#include <vector>
#include <algorithm>
#include <iostream>
#include <unordered_map>
#include <regex>

#include<fstream>

using namespace llvm;

// 分析当前.o.llvm.bc 使用了哪些1全局变量,2函数和3struct类型
// LLVM 9.x

// opt-12  -load ~/Desktop/ko-experiments/IRKmalloc/libIRKmalloc.so  -irusage init/main.ll -disable-output
// opt-12  -load ~/Desktop/ko-experiments/IRKmalloc/libIRKmalloc.so  -irusage ~/Desktop/ko-experiments/linux-5.15.45-vanilla/out-llvm-12/init/main.ll -disable-output

// opt-12  -load ~/Desktop/ko-experiments/IRKmalloc/libIRKmalloc.so  -irusage ~/Desktop/ko-experiments/linux-5.15.45-vanilla/out-llvm-12/net/ipv6/mcast.ll -disable-output

// opt-12  -load ./libIRgetGEP.so -irusage ~/Desktop/ko-experiments/linux-5.15.45-vanilla/out-llvm-12/fs/seq_file.ll 

namespace {


	std::string stripPath(std::string filepath)
	{
		std::regex path_regex1("^.*/\\.\\.");
		// std::regex path_regex2("^\\./\\.\\./");
		std::string res = "";
		// if (std::regex_search(filepath, path_regex2)) {
		//     filepath = filepath.substr(2);
		// }
		if (std::regex_search(filepath, path_regex1)) {
			std::string delimiter = "/";
			std::string s = filepath;
			size_t pos = 0;
			std::vector<std::string> stk;
			std::string token;

			while ((pos = s.find(delimiter)) != std::string::npos) {
				token = s.substr(0, pos);
				s.erase(0, pos + delimiter.length());
				if (token == ".." && !stk.empty()) {
					stk.pop_back();
				} else {
					stk.push_back(token);
				}
				
			}

			for (auto x : stk) {
				res += x + "/";
			}
			res += s;
		} else {
			return filepath;
		}
		return res;
	}

    struct IRUsageModulePass : public llvm::ModulePass {
        static char ID;

        IRUsageModulePass() : ModulePass(ID) {}
        bool runOnModule(Module &M) override;
        std::ofstream write_kof;
        std::ofstream write_so;
        
		// std::string extractStruct(llvm::Type *t);
		// std::vector<allocation*> record;
    };


    bool IRUsageModulePass::runOnModule(Module &M) {
        LLVMContext& CTX = M.getContext();
		std::string currFile = stripPath(M.getName().data());
		
		// std::cout << currFile << std::endl;
        
        
        bool flag_kof = false;
        bool flag_so = false;

		for (auto& F : M) {
			bool flag_alloc = false;
			Value *retv = nullptr;
			for (auto& BB : F) {
				for (auto& I : BB) {

                    if (I.getOpcode() == Instruction::GetElementPtr) {
                        GetElementPtrInst *gi = dyn_cast<GetElementPtrInst>(&I);
                        std::string type_str;
						raw_string_ostream rso(type_str);
						gi->getSourceElementType()->print(rso);

                        if (type_str.find("seq_operations") != std::string::npos) {
                            // write_so << currFile << std::endl;
                            flag_so = true;
                        } else if (type_str.find("kernfs_open_file") != std::string::npos) {
                            // write_kof << currFile << std::endl;
                            flag_kof = true;
                        }
                    }
					
				}
			}
		
		}
        if (flag_kof) {
            write_kof.open("write_kof.txt", std::ios::app);
            write_kof << currFile << std::endl;
            write_kof.close();
        }
        if (flag_so) {
            write_so.open("write_so.txt", std::ios::app);
            write_so << currFile << std::endl;
            write_so.close();
        }
        

        return true;
    }


char IRUsageModulePass::ID = 0;

static RegisterPass<IRUsageModulePass> X(
    "irusage",
    "IRUsage Module Pass",
    false,
    true
);
}
