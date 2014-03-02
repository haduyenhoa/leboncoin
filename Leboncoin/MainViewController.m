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
#import "AnnonceDetailViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
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

    [self performSelectorInBackground:@selector(threadSearchCurrentIndex) withObject:nil];

//    [self performSelectorInBackground:@selector(threadSearchAll) withObject:nil];
}

-(void)mainThreadRefresh {
    if (![NSThread isMainThread]) {
        [self performSelectorOnMainThread:@selector(mainThreadRefresh) withObject:nil waitUntilDone:NO];
        return;
    }
    
    @synchronized(self) {
        NSLog(@"%s",__FUNCTION__);
        if (currentIndex >= ([LeboncoinAgent shareAgent].searchConditions.count - 1)) {
            self.btnNext.enabled = NO;
        } else {
            self.btnNext.enabled = YES;
        }
        
        if (currentIndex <= 0) {
            self.btnPrevious.enabled = NO;
        } else {
            self.btnPrevious.enabled = YES;
        }
        SearchCondition *aSearchCondition = [[LeboncoinAgent shareAgent].searchConditions objectAtIndex:currentIndex];
        NSArray *listResultForCurrentSearch = [dictResult valueForKey:aSearchCondition.uuid];
        [self.tblSearch reloadData];
        if (listResultForCurrentSearch.count > 0) {
            [self.tblSearch scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
        }
        self.tblSearch.alpha = 1.0;
    }
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
    if ([[segue identifier] isEqualToString:@"showAnnonceDetail"]) {
        SearchCondition *aSearchCondition = [[LeboncoinAgent shareAgent].searchConditions objectAtIndex:currentIndex];
        
        NSArray *listAnnonce = [dictResult valueForKey:aSearchCondition.uuid];
        Annonce *anAnnonce = [listAnnonce objectAtIndex:[self.tblSearch indexPathForCell:sender].row];
        
        AnnonceDetailViewController *dest = [segue destinationViewController];
        dest.myAnnonce = anAnnonce;
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

-(void)threadSearchCurrentIndex {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.tblSearch.alpha  = 0.0;
    });
    NSLog(@"%s",__FUNCTION__);
    currentIndex = MIN((int)[LeboncoinAgent shareAgent].searchConditions.count-1, currentIndex);
    currentIndex = MAX(0, currentIndex);
//    
//    [self performSelectorOnMainThread:@selector(mainThreadRefresh) withObject:nil waitUntilDone:NO];
    
    SearchCondition *aCondition = [[LeboncoinAgent shareAgent].searchConditions objectAtIndex:currentIndex];
    [self performSelectorInBackground:@selector(threadRenewSearch:) withObject:aCondition];
}

-(void)threadRenewSearch:(SearchCondition*)aCondition {
    NSArray *result = [[LeboncoinAgent shareAgent] search:aCondition];
    [dictResult setValue:result forKey:aCondition.uuid];
    
    [self performSelectorOnMainThread:@selector(mainThreadRefresh) withObject:nil waitUntilDone:NO];
}

-(void)threadSearchAll {
    NSLog(@"%s",__FUNCTION__);
    [dictResult removeAllObjects];
    
    for (SearchCondition *aSearchCondition in [LeboncoinAgent shareAgent].searchConditions) {
        NSArray *result = [[LeboncoinAgent shareAgent] search:aSearchCondition];
        [dictResult setValue:result forKey:aSearchCondition.uuid];
    }
    
    [self performSelectorOnMainThread:@selector(mainThreadRefresh) withObject:nil waitUntilDone:NO];
}


#pragma mark UITableView 
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return listSearchCondition == nil ? 0 : listSearchCondition.count;
    if (dictResult.allKeys.count == 0) {
        return 0;
    }
    
    return 1;
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    SearchCondition *aSearchCondition = [[LeboncoinAgent shareAgent].searchConditions objectAtIndex:currentIndex];
    
    NSString *title = aSearchCondition.searchKey == nil ? @"[Unknown]": aSearchCondition.searchKey;
    title = [title stringByAppendingFormat:@"- %@ - %@",[aSearchCondition getCategoryName], [aSearchCondition getLocationName]];
    
    return title;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    SearchCondition *aSearchCondition = [[LeboncoinAgent shareAgent].searchConditions objectAtIndex:currentIndex];
    
    NSArray *listResultForCurrentSearch = [dictResult valueForKey:aSearchCondition.uuid];
    return listResultForCurrentSearch.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AnnonceCellId"];
    SearchCondition *aSearchCondition = [[LeboncoinAgent shareAgent].searchConditions objectAtIndex:currentIndex];
    
    NSArray *listAnnonce = [dictResult valueForKey:aSearchCondition.uuid];

    Annonce *anAnnonce = [listAnnonce objectAtIndex:indexPath.row];
    
    UILabel *annonceTitleLabel = (UILabel*)[cell viewWithTag:2];
    annonceTitleLabel.text = anAnnonce.title;
    
    UILabel *annonceDateLabel = (UILabel*)[cell viewWithTag:3];
    annonceDateLabel.text = anAnnonce.dateStr;
    
    UILabel *annonceLocation = (UILabel*)[cell viewWithTag:4];
    annonceLocation.text = anAnnonce.location;
    
    UILabel *annoncePrice = (UILabel*)[cell viewWithTag:5];
    annoncePrice.text = anAnnonce.price;
    
    UIImageView *annonceImage = (UIImageView*)[cell viewWithTag:1];
    
    //configure cell background
    if (anAnnonce.linkImage) {
        if ([dictImage valueForKey:anAnnonce.linkImage]) {
            [annonceImage setImage:[dictImage valueForKey:anAnnonce.linkImage]];
        } else if (anAnnonce.linkImage != nil && ![anAnnonce.linkImage isEqualToString:@""]){
            dispatch_async(dispatch_queue_create("com.company.app.imageQueue", NULL), ^{
                NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:anAnnonce.linkImage]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (imageData) {
                        [dictImage setValue:[UIImage imageWithData:imageData] forKey:anAnnonce.linkImage];
                        [annonceImage setImage:[dictImage valueForKey:anAnnonce.linkImage]];
                        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
                    } else {
                        [annonceImage setImage:[UIImage imageNamed:@"unknownImage.png"]];
                    }
                });
            });
        } else {
            [annonceImage setImage:[UIImage imageNamed:@"unknownImage.png"]];
        }
    } else {
        [annonceImage setImage:[UIImage imageNamed:@"unknownImage.png"]];
    }
    
    if (indexPath.row % 2 == 0) {
        cell.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.4];
    } else {
        cell.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.4];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SearchCondition *aSearchCondition = [[LeboncoinAgent shareAgent].searchConditions objectAtIndex:currentIndex];
    
    NSArray *listAnnonce = [dictResult valueForKey:aSearchCondition.uuid];
    Annonce *anAnnonce = [listAnnonce objectAtIndex:indexPath.row];
    [self showAnonceDetail:anAnnonce];
}

#pragma -


#pragma mark PopOver
-(void)showAnonceDetail:(Annonce*)anAnnonce
{
    //NSLog(@"popover retain count: %d",[popover retainCount]);
    
    SAFE_ARC_RELEASE(popover); popover=nil;
    
    //the controller we want to present as a popover
    AnnonceDetailViewController *controller = [[UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil]instantiateViewControllerWithIdentifier:@"AnnonceDetail"];
    controller.myAnnonce = anAnnonce;
//    AnnonceDetail *anAnnounceDetail = [[LeboncoinAgent shareAgent] getAnnonceDetail:anAnnonce];
    
    popover = [[FPPopoverKeyboardResponsiveController alloc] initWithViewController:controller];
    popover.tint = FPPopoverDefaultTint;
    
    popover.contentSize = CGSizeMake(320, 500);
    
    popover.arrowDirection = FPPopoverNoArrow;
//    [popover presentPopoverFromPoint: CGPointMake(self.view.center.x, self.view.center.y - popover.contentSize.height/2)];
    [popover presentPopoverFromPoint: CGPointMake(self.view.center.x, 30)];
    
}
#pragma -

#pragma mark Actions
-(IBAction)nextSearch:(id)sender {
    currentIndex++;
    currentIndex = MIN((int)[LeboncoinAgent shareAgent].searchConditions.count-1, currentIndex);
    
    [self performSelectorInBackground:@selector(threadSearchCurrentIndex) withObject:nil];
}

-(IBAction)previousSearch:(id)sender {
    currentIndex --;
    currentIndex = MAX(0, currentIndex);
    
    [self performSelectorInBackground:@selector(threadSearchCurrentIndex) withObject:nil];
}
#pragma -
@end
