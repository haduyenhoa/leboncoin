//
//  MainViewController.m
//  Leboncoin
//
//  Created by Duyen Hoa Ha on 20/12/2013.
//  Copyright (c) 2013 Duyen Hoa Ha. All rights reserved.
//

#import "MainViewController.h"
#import "LeboncoinAgent.h"
#import "SearchCondition.h"
#import "Annonce.h"
#import "LeboncoinAgent.h"


@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //create an annonce
    SearchCondition *newSearchCondition = [[SearchCondition alloc] init];
    newSearchCondition.page = 1;
    newSearchCondition.searchCategory = SC_IMAGE_SON;
    newSearchCondition.searchRegion = SL_ILE_DE_FRANCE;
    newSearchCondition.searchKey = @"cabasse";
    
    listSearchCondition = [NSArray arrayWithObject:newSearchCondition];
    
    dictResult  = [[NSMutableDictionary alloc] init];
    dictImage  = [[NSMutableDictionary alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
//    [[LeboncoinAgent shareAgent] scheduleSearch];
    [self performSelectorInBackground:@selector(threadSearchAll) withObject:nil];
}

-(void)mainThreadRefresh {
    [self.tblSearch reloadData];
}


#pragma mark - Flipside View Controller

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.flipsidePopoverController dismissPopoverAnimated:YES];
    }
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    self.flipsidePopoverController = nil;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showAlternate"]) {
        [[segue destinationViewController] setDelegate:self];
        
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            UIPopoverController *popoverController = [(UIStoryboardPopoverSegue *)segue popoverController];
            self.flipsidePopoverController = popoverController;
            popoverController.delegate = self;
        }
    }
}

- (IBAction)togglePopover:(id)sender
{
    if (self.flipsidePopoverController) {
        [self.flipsidePopoverController dismissPopoverAnimated:YES];
        self.flipsidePopoverController = nil;
    } else {
        [self performSegueWithIdentifier:@"showAlternate" sender:sender];
    }
}


-(void)threadSearchAll {
    [dictResult removeAllObjects];
    
    for (SearchCondition *aSearchCondition in listSearchCondition) {
        NSArray *result = [[LeboncoinAgent shareAgent] search:aSearchCondition];
        [dictResult setValue:result forKey:aSearchCondition.uuid];
    }
    
    [self performSelectorOnMainThread:@selector(mainThreadRefresh) withObject:nil waitUntilDone:NO];
}


#pragma mark UITableView 
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return listSearchCondition == nil ? 0 : listSearchCondition.count;
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    SearchCondition *aSearchCondition = (SearchCondition*)[listSearchCondition objectAtIndex:section];
    
    NSString *title = aSearchCondition.searchKey == nil ? @"[Unknown]": aSearchCondition.searchKey;
    title = [title stringByAppendingFormat:@"- %@ - %@",[aSearchCondition getCategoryName], [aSearchCondition getLocationName]];
    
    return title;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *listAnnonce = [dictResult valueForKey:((SearchCondition*)[listSearchCondition objectAtIndex:section]).uuid];
    return listAnnonce.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AnnonceCellId"];
    NSArray *listAnnonce = [dictResult valueForKey:((SearchCondition*)[listSearchCondition objectAtIndex:indexPath.section]).uuid];
    Annonce *anAnnonce = [listAnnonce objectAtIndex:indexPath.row];
    
    UILabel *annonceTitleLabel = (UILabel*)[cell viewWithTag:2];
    annonceTitleLabel.text = anAnnonce.title;
    
    UILabel *annonceDateLabel = (UILabel*)[cell viewWithTag:3];
    annonceDateLabel.text = anAnnonce.dateStr;
    
    UIImageView *annonceImage = (UIImageView*)[cell viewWithTag:1];
    
    //configure cell background
    if (anAnnonce.linkImage) {
        if ([dictImage valueForKey:anAnnonce.linkImage]) {
            [annonceImage setImage:[dictImage valueForKey:anAnnonce.linkImage]];
        } else {
            dispatch_async(dispatch_queue_create("com.company.app.imageQueue", NULL), ^{
                NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:anAnnonce.linkImage]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [dictImage setValue:[UIImage imageWithData:imageData] forKey:anAnnonce.linkImage];
                    [annonceImage setImage:[dictImage valueForKey:anAnnonce.linkImage]];
                    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
                });
            });
        }

    }
    
    return cell;
}

#pragma -

@end
