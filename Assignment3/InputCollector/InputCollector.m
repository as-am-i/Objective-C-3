//
//  InputCollector.m
//  Demo
//

#import "InputCollector.h"

@implementation InputCollector

+ (NSString *)inputForPrompt:(NSString *)promptString {
    
    char option[255];
    NSLog(@"%@",promptString);
    fgets(option, 255, stdin);
    
    NSString *textTyped = [NSString stringWithUTF8String:option];
    NSString *text = [textTyped stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    return text;
}

+ (void)printToPrompt:(NSString *)promptString {
    
    NSLog(@"%@",promptString);
}

@end
