//
//  MainViewController.m
//  Leboncoin
//
//  Created by Duyen Hoa Ha on 20/12/2013.
//  Copyright (c) 2013 Duyen Hoa Ha. All rights reserved.
//

#import "SearchResultViewController.h"
#import "LeboncoinAgent.h"
#import "SearchCondition.h"
#import "Annonce.h"
#import "LeboncoinAgent.h"
#import "AnnonceDetailViewController.h"
#import "PKHPickerContainerView.h"

@interface SearchResultViewController () {
    PKHPickerContainerView *_pickerContainerView;
    
    int _direction; //1: up; 2: down; 0: nothing
    
    SearchCondition *_currentSearchCondition;
    
    BOOL _isSearchEnabled;
    
    int numberOfPages;
    int currentPage;
}

@end

@implementation SearchResultViewController

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

}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"%s",__FUNCTION__);
    self.tblSearch.alpha  = 0.0;
    
    currentPage = 1;
    
    [self performSelectorInBackground:@selector(threadSearchCurrentIndex) withObject:nil];
}

-(void)mainThreadRefresh {
    if (![NSThread isMainThread]) {
        [self performSelectorOnMainThread:@selector(mainThreadRefresh) withObject:nil waitUntilDone:NO];
        return;
    }
    
    @synchronized(self) {
        NSLog(@"%s",__FUNCTION__);
        if (self.pageIndex >= ([LeboncoinAgent shareAgent].searchConditions.count - 1)) {
            self.btnNext.enabled = NO;
        } else {
            self.btnNext.enabled = YES;
        }
        
        if (self.pageIndex <= 0) {
            self.btnPrevious.enabled = NO;
        } else {
            self.btnPrevious.enabled = YES;
        }
        
        NSArray *listResultForCurrentSearch = [dictResult valueForKey:_currentSearchCondition.uuid];
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
//        SearchCondition *aSearchCondition = [[LeboncoinAgent shareAgent].searchConditions objectAtIndex:self.pageIndex];
        
        NSArray *listAnnonce = [dictResult valueForKey:_currentSearchCondition.uuid];
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
    NSLog(@"%s",__FUNCTION__);
    self.pageIndex = MIN((int)[LeboncoinAgent shareAgent].searchConditions.count-1, self.pageIndex);
    self.pageIndex = MAX(0, self.pageIndex);
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [self enableSearch:YES];
    }];
    
    _currentSearchCondition = [[LeboncoinAgent shareAgent].searchConditions objectAtIndex:self.pageIndex];
    [self performSelectorInBackground:@selector(threadRenewSearch:) withObject:_currentSearchCondition];
}

-(void)threadRenewSearch:(SearchCondition*)aCondition {
    //edit currentpage
    aCondition.page = currentPage;
    
    NSString *title = aCondition.searchTitle == nil ? @"[Unknown]": aCondition.searchTitle;
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        self.lblSearchTitle.text = title;
        self.sbCustomizedSearch.text = title;
    }];
    
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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    SearchCondition *aSearchCondition = [[LeboncoinAgent shareAgent].searchConditions objectAtIndex:self.pageIndex];
    
    NSArray *listResultForCurrentSearch = [dictResult valueForKey:_currentSearchCondition.uuid];
    if (listResultForCurrentSearch  && listResultForCurrentSearch.count > 0) {
        return listResultForCurrentSearch.count + 1;
    } else {
        return 0;
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    
    NSArray *listAnnonce = [dictResult valueForKey:_currentSearchCondition.uuid];
    
    if (indexPath.row < listAnnonce.count) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"AnnonceCellId"];
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
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"SearchPageNavigationCellId"];
        if (currentPage == 1) {
            [cell viewWithTag:1001].alpha = 0;
            [cell viewWithTag:1002].alpha = 0;
        } else {
            [cell viewWithTag:1001].alpha = 1.0;
            [cell viewWithTag:1002].alpha = 1.0;
        }
        NSLog(@"for next & previous line");
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *listAnnonce = [dictResult valueForKey:_currentSearchCondition.uuid];
    if (indexPath.row < listAnnonce.count) {
        Annonce *anAnnonce = [listAnnonce objectAtIndex:indexPath.row];
        [self showAnonceDetail:anAnnonce];
    }
}

-(IBAction)nextPage:(id)sender {
    currentPage++;
    NSLog(@"go to page %d",currentPage);
    
    [self performSelectorInBackground:@selector(threadSearchCurrentIndex) withObject:nil];
}

-(IBAction)previousPage:(id)sender {
    currentPage--;
    currentPage = MAX(1, currentPage);
    NSLog(@"go to page %d",currentPage-1);
    
    [self performSelectorInBackground:@selector(threadSearchCurrentIndex) withObject:nil];
}

-(IBAction)firstPage:(id)sender {
    currentPage = 1;
    NSLog(@"goto first page");
    
    [self performSelectorInBackground:@selector(threadSearchCurrentIndex) withObject:nil];
}
#pragma -

#pragma mark Scroll view
-(void)enableSearch:(BOOL)enabled {
    if (_isSearchEnabled == enabled) {
        NSLog(@"do not change to same state");
        return;
    }
    
    _isSearchEnabled = enabled;
    
    //scroll up
    [UIView beginAnimations:@"hide search" context:nil];
    [UIView setAnimationDuration:0.6];

    if (_isSearchEnabled) {
        self.sbCustomizedSearch.alpha = 1.0;
        self.lblSearchTitle.alpha = 0.0;
    } else {
        self.sbCustomizedSearch.alpha = 0.0;
        self.lblSearchTitle.alpha = 1.0;
    }

    [self.constraintMainTable setConstant:_isSearchEnabled ? 40 : 20];
    
    [UIView commitAnimations];
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (decelerate) {
        if (_direction == 1) {
            NSLog(@"decelerating to top");
            [self enableSearch:NO];
        } else if (_direction == 2) {
            NSLog(@"decelerating to bottom");
            //scroll down
            [self enableSearch:YES];
        }
    } else {
        _direction = 0;
    }
}

-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    if (velocity.y > 0){
        _direction = 1; //up
    } else if (velocity.y < 0){
        _direction = 2; //down
    } else {
        _direction = 0;
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"scroll end");
}
#pragma -

#pragma mark PopOver
-(void)showAnonceDetail:(Annonce*)anAnnonce
{
    
    //the controller we want to present as a popover
    AnnonceDetailViewController *controller = [[UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil]instantiateViewControllerWithIdentifier:@"AnnonceDetail"];
    controller.myAnnonce = anAnnonce;
//    AnnonceDetail *anAnnounceDetail = [[LeboncoinAgent shareAgent] getAnnonceDetail:anAnnonce];
    [controller hideSendEmail:nil];
    
    [self.navigationController pushViewController:controller animated:YES];
    
//    popover = [[FPPopoverKeyboardResponsiveController alloc] initWithViewController:controller];
//    popover.tint = FPPopoverDefaultTint;
//    
//    popover.contentSize = CGSizeMake(320, 500);
//    
//    popover.arrowDirection = FPPopoverNoArrow;
////    [popover presentPopoverFromPoint: CGPointMake(self.view.center.x, self.view.center.y - popover.contentSize.height/2)];
//    [popover presentPopoverFromPoint: CGPointMake(self.view.center.x, 30)];
    
}
#pragma -

#pragma mark Search bar 
-(void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar {
    [self pickerButtonAction:nil];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"%s",__FUNCTION__);
    [searchBar resignFirstResponder];
    
    _currentSearchCondition.searchKey = searchBar.text;
    
    [self performSelectorInBackground:@selector(threadSearchCurrentIndex) withObject:nil];
}

-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    searchBar.text = _currentSearchCondition.searchKey;
    searchBar.showsCancelButton = YES;
    return YES;
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    searchBar.showsCancelButton = NO;
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}
#pragma -

#pragma mark Actions
-(IBAction)nextSearch:(id)sender {
    NSLog(@"%s",__FUNCTION__);
    self.pageIndex++;
    currentPage = 1;
    self.pageIndex = MIN((int)[LeboncoinAgent shareAgent].searchConditions.count-1, self.pageIndex);
    
    [self performSelectorInBackground:@selector(threadSearchCurrentIndex) withObject:nil];
}

-(IBAction)previousSearch:(id)sender {
    NSLog(@"%s",__FUNCTION__);
    self.pageIndex --;
    currentPage = 1;
    self.pageIndex = MAX(0, self.pageIndex);
    
    [self performSelectorInBackground:@selector(threadSearchCurrentIndex) withObject:nil];
}

- (IBAction)pickerButtonAction:(id)sender {
    
    if (!_pickerContainerView) {
        _pickerContainerView = [[PKHPickerContainerView alloc] initWithinView:self.view];
        _pickerContainerView.backgroundColor = [UIColor lightGrayColor];
        [_pickerContainerView.pickerView setDataSource:self];
        [_pickerContainerView.pickerView setDelegate:self];

        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneButtonAction:)];
        UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelButtonAction:)];
        UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        
        [_pickerContainerView setToolbarItems:@[cancelButton,spacer,doneButton]];
        
        
        
        [self.view addSubview:_pickerContainerView];

        [_pickerContainerView.pickerView selectRow:self.pageIndex inComponent:0 animated:NO];

        
        [_pickerContainerView showPickerContainerView];
        
    }
    
}


- (IBAction)doneButtonAction:(id)sender {
    self.pageIndex = [_pickerContainerView.pickerView selectedRowInComponent:0];
    currentPage = 1;
    
    if (self.controller) {
        [self.controller jumpToPage:self.pageIndex];
    }
    
    /*
    _currentSearchCondition = (SearchCondition*)[[LeboncoinAgent shareAgent].searchConditions objectAtIndex:self.pageIndex];
    NSString *title = _currentSearchCondition.searchTitle == nil ? @"[Unknown]": _currentSearchCondition.searchTitle;
//    title = [title stringByAppendingFormat:@" - %@ - %@",[_currentSearchCondition getCategoryName], [_currentSearchCondition getLocationName]];
    NSLog(@"Chosen: %@",title);
    
    [_pickerContainerView hidePickerContainerView];
    _pickerContainerView = nil;
    
    [self performSelectorInBackground:@selector(threadSearchCurrentIndex) withObject:nil];
    */
}

- (IBAction)cancelButtonAction:(id)sender {
    
    [_pickerContainerView hidePickerContainerView];
    _pickerContainerView = nil;
    
}

#pragma -

#pragma mark - Picker Delegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 40;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [[LeboncoinAgent shareAgent].searchConditions count];;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    SearchCondition *aCondition = (SearchCondition*)[[LeboncoinAgent shareAgent].searchConditions objectAtIndex:row];
    NSString *title = aCondition.searchTitle == nil ? @"[Unknown]": aCondition.searchTitle;
//    title = [title stringByAppendingFormat:@" - %@ - %@",[aCondition getCategoryName], [aCondition getLocationName]];
    return title;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
}
@end
