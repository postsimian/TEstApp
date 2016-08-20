//
//  MediaManager.m
//  TEstApp
//
//  Created by Janell Lantana on 2/23/14.
//  Copyright (c) 2014 janelllantana. All rights reserved.
//

#import "MediaManager.h"
#import "MediaObject.h"

@implementation MediaManager

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
 // Removing temporarily until further notice from instructor
// NSLog(@"inside the fetchPopularMediaWithCompletionBlock method!");
//    completionBlock(NO);
    
    NSString *instagramEndpoint = @"https://api.instagram.com/v1/media/popular?client_id=5609d2fb2bf74d749716bd00a9090e5e";
    NSURL *URL = [NSURL URLWithString:instagramEndpoint];
    
    // 1. Get a reference to the shared NSURLSession
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithURL: URL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
          //handle response
          
          // 2. Invoke the dataTaskWithURL:completionHandler: method on the shared NSURLSession
          
          // 3. In the completionHandler, check that the response has status code 200. If yes, call completionBlock(YES). If no, call completionBlock(NO).
          
          // 4. Make sure you call the NSURLSessionDataTask method that actually initiates the task
          NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
          if (httpResponse.statusCode == 200)
          {
             // completionBlock(YES);
              // Use the NSJSONSerialization to convert the data into an NSDictionary
              // Check to see if serialization generated an NSError
              // If yes, call completion(NO). If no, NSLog the dictionary and call completionBlock(YES).
                  NSError *JSONParseError = nil;
                  NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                             options:NSJSONReadingAllowFragments
                                                                               error:&JSONParseError];
                  if (JSONParseError)
                  {
                      completionBlock(NO);
                  }
                  else
                  {
                      self.mediaObjects = [self mediaObjectsFromResponse:dictionary];
                      completionBlock(YES);
                  }
              }
          else
          {
              completionBlock(NO);
          }
          
      }];
     [task resume];
}

- (NSArray *)mediaObjectsFromResponse:(NSDictionary *)response
{
    NSMutableArray * mediaObjects = [NSMutableArray array];
    
    NSArray *data = [response valueForKey:@"data"];
    for (NSDictionary *mediaDictionary in data)
    {
        MediaObject *mediaObject = [[MediaObject alloc] initWithDictionary:mediaDictionary];
        [mediaObjects addObject:mediaObject];
    }
    
    return mediaObjects;
}
@end
