//
//  Input.m
//  Assignment3
//
//  Created by 谷井朝美 on 2018-04-23.
//  Copyright © 2018 Asami Tanii. All rights reserved.
//

#import "Input.h"
#import "InputCollector.h"

@implementation Input

- (instancetype) init{
    self = [super init];
    if (self) {
        _commands = [NSMutableArray array];
    }
    return self;
}

- (void) showLastThreeCommands{
    NSString *result;
    int cnt = (int) [[self commands] count];
    if (cnt == 2) {
        NSString *first = [[self commands] firstObject];
        [InputCollector printToPrompt:first];
        
        NSString *last = [[self commands] lastObject];
        [InputCollector printToPrompt:last];
    } else if (cnt == 1) {
        result = [[self commands] firstObject];
        [InputCollector printToPrompt:result];
    } else if (cnt >= 3) {
        int startIndex = cnt -3;
        for (int i = startIndex; i < cnt ; i++) {
            NSString *command =[[self commands] objectAtIndex:i];
            result = [NSString stringWithFormat:@"%@", command];
            [InputCollector printToPrompt:result];
        }
    }
}
@end
