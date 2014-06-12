//
//  SearchManagerViewController.m
//  Leboncoin
//
//  Created by Duyen Hoa Ha on 03/01/2014.
//  Copyright (c) 2014 Duyen Hoa Ha. All rights reserved.
//

#import "SearchManagerViewController.h"
#import "LeboncoinAgent.h"
#import "SearchCondition.h"
#import "SearchEditViewController.h"

#define kTagSearchTitle         100

@interface SearchManagerViewController ()

@end

@implementation SearchManagerViewController

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
    
    [self.tblSearchConditions reloadData];
}

#pragma mark UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [LeboncoinAgent shareAgent].searchConditions == nil? 0 : [LeboncoinAgent shareAgent].searchConditions.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchItemCellId"];
    
    UILabel *lblSearchTitle = nil;
    if (IS_OS_7_OR_LATER) {
        lblSearchTitle = (UILabel*)[cell.contentView viewWithTag:kTagSearchTitle];
    } else {
        lblSearchTitle = (UILabel*)[cell viewWithTag:kTagSearchTitle];
    }
    
    lblSearchTitle.text = ((SearchCondition*)[[LeboncoinAgent shareAgent].searchConditions objectAtIndex:indexPath.row]).searchTitle;
    
    return cell;
}

#pragma -

-(IBAction)updateLeboncoinSearchsViaLink:(id)sender {
    NSString *dropBoxLink = @"https://dl.dropboxusercontent.com/s/fau2t681lydkl29/leboncoin.xml?dl=1";
    NSString *libraryPath = [[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"leboncoin.xml"];
    
    NSString *remoteContent = [NSString stringWithContentsOfURL:[NSURL URLWithString:dropBoxLink] encoding:NSUTF8StringEncoding error:nil];
    if (remoteContent) {
        NSString *tempFilePath = [[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"tempLeboncoin.xml"];
        if ([[NSFileManager defaultManager] fileExistsAtPath:tempFilePath isDirectory:nil]) {
            [[NSFileManager defaultManager] removeItemAtPath:tempFilePath error:nil];
        }
        
        [[NSFileManager defaultManager] moveItemAtPath:libraryPath toPath:tempFilePath error:nil];
        if ([remoteContent writeToFile:libraryPath atomically:YES encoding:NSUTF8StringEncoding error:nil]) {
            NSLog(@"write new file from drop box OK");
            [[NSFileManager defaultManager] removeItemAtPath:tempFilePath error:nil];
        }
        
        [LeboncoinAgent shareAgent].searchConditions = [[LeboncoinAgent shareAgent] getSearchConditionsFromFile:libraryPath];
    } else {
        NSLog(@"cannot get content at %@ ",dropBoxLink);
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"modifySearchCondition"]) {
        SearchEditViewController *dest = segue.destinationViewController;
        NSIndexPath *path = [self.tblSearchConditions indexPathForCell:sender];
        
        [dest setHandleSearchCondition:[[LeboncoinAgent shareAgent].searchConditions objectAtIndex:path.row]];
    }
}

@end
