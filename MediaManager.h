//
//  MediaManager.h
//  TEstApp
//
//  Created by Janell Lantana on 2/23/14.
//  Copyright (c) 2014 janelllantana. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MediaManager : NSObject
@property (nonatomic, strong) NSArray *mediaObjects;

- (void)fetchPopularMediaWithCompletionBlock:(void (^)(BOOL success))completionBlock;


@end
