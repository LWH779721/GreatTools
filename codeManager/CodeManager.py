#!/usr/bin/env python3

#需求：实现编码目录管理系统
#需求细节：
#1. 创建 code space
#2. 创建 C/C++ 头文件
#3. 创建 C 主文件

import sys

def create_c_source(file_name):
    f = open(file_name,'w',encoding="utf-8")
    f.writelines(
'''#include <stdio.h>

int main(int argc, char **args)
{
    return 0;
}
''')   
    f.close()

def create_c_header(file_name):
    header_tag = "__%s_H__"%(file_name.split('.')[0].upper())
    code = '''#ifndef %s
#define %s

#ifdef __cplusplus
extern "C"{
#endif


#ifdef __cplusplus
}
#endif
#endif
'''%(header_tag, header_tag)
    f = open(file_name,'w',encoding="utf-8")
    f.writelines(code)   
    f.close()
    
def space_init():

	pass

if __name__ == "__main__":
    if sys.argv[1].endswith(".c"):
        create_c_source(sys.argv[1])
    elif sys.argv[1].endswith(".h"):
        create_c_header(sys.argv[1])
        
