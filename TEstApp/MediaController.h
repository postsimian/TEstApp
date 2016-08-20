//
//  MediaController.h
//  TEstApp
//
//  Created by Janell Lantana on 2/22/14.
//  Copyright (c) 2014 janelllantana. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MediaController : NSObject

@property (nonatomic, strong) NSArray *mediaObjects;

- (void)fetchPopularMediaWithCompletionBlock:(void (^)(BOOL success))completionBlock;

// + (BOOL)isValidElment:(id)element;

@end
