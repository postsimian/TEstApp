//
//  PopularMediaViewController.m
//  TEstApp
//
//  Created by Janell Lantana on 2/22/14.
//  Copyright (c) 2014 janelllantana. All rights reserved.
//

#import "PopularMediaViewController.h"
#import "MediaManager.h"
#import "MediaObject.h"
#import "ImageViewController.h"

@interface PopularMediaViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong)IBOutlet UITableView *tableView;
@property (nonatomic, strong)MediaManager *mediaManager;

@end

@implementation PopularMediaViewController

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
    self.view.backgroundColor = [UIColor magentaColor];
    // Do any additional setup after loading the view from its nib.
    
    
    //Do any additional setup after loading the view.
    
    self.mediaManager = [[MediaManager alloc] init];
    [self updateContent];
    
    UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(didTapRefresh:)];
    self.navigationItem.rightBarButtonItem = refreshButton;
}

- (void)didTapRefresh:(UIBarButtonItem *)sender
{
    [self updateContent];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView Delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ImageViewController *viewController = [[ImageViewController alloc] initWithNibName:@"ImageViewController" bundle:Nil];
    viewController.mediaObject = [self.mediaManager.mediaObjects objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark - UITableView Datasource

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    // Get the mediaObject at indexPath.row
    MediaObject *object = [self.mediaManager.mediaObjects objectAtIndex:indexPath.row];
    
    // Set the cell's textLabel to the mediaObject's username
    cell.textLabel.text = object.username;
    
    //cell.textLabel.text=@"Placeholder Title";
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return 5;
    // Return the number of objects in the self.mediaManager.mediaObjects array
    return [self.mediaManager.mediaObjects count];
}

- (void)updateContent
{
    [self.mediaManager fetchPopularMediaWithCompletionBlock:^(BOOL success){
     
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            if (success)
        {
                  // Reload the tableview here
           // NSLog(@"success!");
            [self.tableView reloadData];
        }
        else
        {
 // Alert the user that the request failed
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Uh Oh!"
                                                             message:@"An error occurred"
                                                            delegate:nil
                                                   cancelButtonTitle:@"Okay"
                                                   otherButtonTitles:nil];
            [alert show];
 
        }
    });
    }];
}

@end
