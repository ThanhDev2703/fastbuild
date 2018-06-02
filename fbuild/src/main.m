//
//  main.m
//  FastBuildSimple
//
//  Created by fsociety on 5/27/18.
//  Copyright © 2018 fsociety. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <unistd.h>
#include <sys/types.h>
#include <pwd.h>
#include "Config.h"
#import "Utils.h"
#import "AutoConfig.h"
#import "CompilerHelper.h"
#import "FileHelper.h"

void checkArgs(int argc, const char * argv[]);
void PrintCopyRight()
{
    printf("%s\
d88888b d8    8b '88      88' .d8888.  .d88b.   .o88b. d888888b d88888b d888888b db    db\n\
88'     8P    Y8   '88  88'   88'  YP .8P  Y8. d8P  Y8   `88'   88         88    `8b  d8'\n\
88ooo   88    88     '88'     `8bo.   88    88 8P         88    88ooooo    88     `8bd8'\n\
88      88    88     '88'       `Y8b. 88    88 8b         88    88         88       88\n\
88      '8b  d8'   'db  8D'   db   8D `8b  d8' Y8b  d8   .88.   88.        88       88\n\
YP       'Y88P'  '88      88' '8888Y'  `Y88P'   `Y88P' Y888888P Y88888P    YP       YP\n\n%s",kRED,kRS);
    
    printf("                  }-------{+} fastbuild xcode project {+}-------{}\n");
    printf("                   }-------{+} Coded by fuxsociety {+}-------{}\n\n");
}


int main(int argc, const char * argv[])
{
    NSString *cmdInitFolder = [NSString stringWithFormat:@"mkdir -p %@/",getConfigPath()];
    system(cmdInitFolder.UTF8String);
    
    currentDIR = GetSystemCall(@"pwd");
    
//#ifdef DEBUG
//    currentDIR = @"/Volumes/Workspace/ominext/assignmnent/ios";
//#endif
    
    PrintCopyRight();
    printf("[ENV] %s\n",currentDIR.UTF8String);
    checkArgs(argc, argv);
    writeListFileSwift();
    compileAllModifiedFile();
    
    return 0;
}

void checkArgs(int argc, const char * argv[])
{
    if (argc >= 2)
    {
        NSString *param2 = [NSString stringWithUTF8String:argv[1]];
        if ([param2 isEqualToString:@"init"])
        {
            initConfigFile();
            
            exit(0);
        }
        
        if ([param2 isEqualToString:@"config"] && argc >= 3)
        {
            NSString *projectName = [NSString stringWithUTF8String:argv[2]];
            
            autoConfig(projectName);
            
            exit(0);
        }
        
        if ([param2 isEqualToString:@"version"])
        {
            printf("%s\n",kVersion);
            exit(0);
        }
        
        if ([param2 isEqualToString:@"all"])
        {
            compileAllSourceAndRebuild();
            exit(0);
        }
    }
}
