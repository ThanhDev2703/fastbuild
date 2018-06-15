//
//  Utils.m
//  fbuild
//
//  Created by fuxsociety on 6/2/18.
//  Copyright © 2018 fsociety. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Utils.h"
#import <stdio.h>
NSString *currentDIR;

NSString * GetSystemCall(NSString *cmd)
{
    cmd = [cmd stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    NSString *tempFilePath = [NSString stringWithFormat:@"%@/Temp.out",getConfigPath()];
    NSString *reCmd = [NSString stringWithFormat:@"%@ &> %@",cmd,tempFilePath];
    system(reCmd.UTF8String);
    
    NSString *output = [[NSString alloc] initWithContentsOfFile:tempFilePath encoding:NSUTF8StringEncoding error:nil];
    return [output stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}


NSString *GetHomeDir()
{
    char *home = getenv("HOME");
    return [[NSString alloc] initWithUTF8String:home];
}

NSString *getConfigPath()
{
    return [NSString stringWithFormat:@"%@/Library/Developer/fastbuild",GetHomeDir()];
}

NSString *GetFileNameFromFilePath(NSString *filePath)
{
    NSArray *components = [filePath componentsSeparatedByString:@"/"];
    NSString *filePathAndEx = [components lastObject];
    NSArray *fileComponents = [filePathAndEx componentsSeparatedByString:@"."];
    return [fileComponents firstObject];
}

void print(const char * __restrict format, ...)
{
    char buffer[4096];
    va_list args;
    va_start(args, format);
    vsprintf(buffer,format,args);
    va_end(args);
    
    for (int i = 0; i < strlen(buffer); i++) {
        printf("%c",buffer[i]);
        usleep(5000);
        fflush(stdout);
    }
}
