//
//  SearchLocationSelectorViewController.m
//  Leboncoin
//
//  Created by Duyen Hoa Ha on 01/05/2014.
//  Copyright (c) 2014 Duyen Hoa Ha. All rights reserved.
//

#import "SearchLocationSelectorViewController.h"

#import "SearchCondition.h"
#import "LeboncoinAgent.h"
#define kTagSearchRegionTitle       100

@interface SearchLocationSelectorViewController () {
    NSDictionary *dictSearchLocations;
    NSDictionary *dictLBCSearchLocations;
}

@end

@implementation SearchLocationSelectorViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(void)loadSearchRegionDict {
    dictLBCSearchLocations = @{[NSString stringWithFormat:@"%d",SL_LA_FRANCE]: [[LeboncoinAgent shareAgent] getLocationName:SL_LA_FRANCE]
                               ,[NSString stringWithFormat:@"%d",SL_VOISIN_IDF]: [[LeboncoinAgent shareAgent] getLocationName:SL_VOISIN_IDF]
                               ,[NSString stringWithFormat:@"%d",SL_ILE_DE_FRANCE]: [[LeboncoinAgent shareAgent] getLocationName:SL_ILE_DE_FRANCE]
                               ,[NSString stringWithFormat:@"%d",SL_HAUT_DE_SEINE]: [[LeboncoinAgent shareAgent] getLocationName:SL_HAUT_DE_SEINE]
                               ,[NSString stringWithFormat:@"%d",SL_PARIS]: [[LeboncoinAgent shareAgent] getLocationName:SL_PARIS]
                               };
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self loadSearchRegionDict];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tblSearchLocations reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark UITableView
-(int)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dictLBCSearchLocations.allKeys.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchRegionCellId"];
    UILabel *lblCategoryTitle = nil;
    if (IS_OS_7_OR_LATER) {
        lblCategoryTitle = (UILabel*)[cell.contentView viewWithTag:kTagSearchRegionTitle];
    } else {
        lblCategoryTitle = (UILabel*)[cell viewWithTag:kTagSearchRegionTitle];
    }
    
    lblCategoryTitle.text = [dictLBCSearchLocations objectForKey:[dictLBCSearchLocations.allKeys objectAtIndex:indexPath.row]];
    
    if (self.handleSearchCondition && self.handleSearchCondition.searchRegion == ((NSNumber*)[dictLBCSearchLocations.allKeys objectAtIndex:indexPath.row]).intValue) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.handleSearchCondition) {
        self.handleSearchCondition.searchRegion = ((NSNumber*)[dictLBCSearchLocations.allKeys objectAtIndex:indexPath.row]).intValue;
    }
    [self.tblSearchLocations reloadData];
}
#pragma -

@end
