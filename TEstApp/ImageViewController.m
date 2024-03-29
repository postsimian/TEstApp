//
//  ImageViewController.m
//  TEstApp
//
//  Created by Janell Lantana on 2/23/14.
//  Copyright (c) 2014 janelllantana. All rights reserved.
//

#import "ImageViewController.h"
#import "MediaObject.h"
#import "PopularMediaViewController.h"
#import "MediaManager.h"

@interface ImageViewController ()
@property (nonatomic, strong)IBOutlet UIImageView *imageView;

@end

@implementation ImageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = self.mediaObject.username;
    
    //Ensure that our UI elements begin just after the navigationBar rather than beneath it
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self setupImageView];
}

#pragma mark - Setup
-(void)setupImageView
{
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDownloadTask *getImageTask = [session downloadTaskWithURL:self.mediaObject.imageURL completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error)
    {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if (httpResponse.statusCode == 200)
        {
            UIImage *downloadedImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:location]];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.imageView.image = downloadedImage;
            });
    }
    }];
    [getImageTask resume];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
