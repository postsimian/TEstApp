//
//  MediaController.m
//  TEstApp
//
//  Created by Janell Lantana on 2/22/14.
//  Copyright (c) 2014 janelllantana. All rights reserved.
//

#import "MediaController.h"



@implementation MediaController

- (id)init
{
    self = [super init];
    if (self)
    {
        self.mediaObjects = [NSArray array];
    }
    return self;
}

- (void)fetchPopularMediaWithCompletionBlock:(void (^)(BOOL success))completionBlock
{
    NSLog(@"inside the fetchPopularMediaWithCompletionBlock method!");
    
    completionBlock(NO);
}

@end
