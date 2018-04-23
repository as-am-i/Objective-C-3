//
//  InputCollector.h
//  Demo
//

#import <Foundation/Foundation.h>

@interface InputCollector : NSObject

+ (NSString *)inputForPrompt:(NSString *)promptString;

+ (void)printToPrompt:(NSString *)promptString;

@end
