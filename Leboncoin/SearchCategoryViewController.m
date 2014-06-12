//
//  SearchCategoryViewController.m
//  Leboncoin
//
//  Created by Duyen Hoa Ha on 01/05/2014.
//  Copyright (c) 2014 Duyen Hoa Ha. All rights reserved.
//

#import "SearchCategoryViewController.h"
#import "SearchCondition.h"
#import "LeboncoinAgent.h"
#define kTagCategoryTitleLabel      100

@interface SearchCategoryViewController () {
    NSDictionary *dictSearchCategories;
    NSDictionary *dictLBCSearchCategories;
    
}

@end

@implementation SearchCategoryViewController

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

-(void)loadSearchCategoryDict {
    dictLBCSearchCategories = @{[NSString stringWithFormat:@"%d",SC_ALL]: [[LeboncoinAgent shareAgent] getCategoryName:SC_ALL]
                                ,[NSString stringWithFormat:@"%d",SC_AUTO]: [[LeboncoinAgent shareAgent] getCategoryName:SC_AUTO]
                                ,[NSString stringWithFormat:@"%d",SC_ELECTROMENAGER]: [[LeboncoinAgent shareAgent] getCategoryName:SC_ELECTROMENAGER]
                                ,[NSString stringWithFormat:@"%d",SC_EQUIPEMENT_AUTO]: [[LeboncoinAgent shareAgent] getCategoryName:SC_EQUIPEMENT_AUTO]
                                ,[NSString stringWithFormat:@"%d",SC_IMAGE_SON]: [[LeboncoinAgent shareAgent] getCategoryName:SC_IMAGE_SON]
                                ,[NSString stringWithFormat:@"%d",SC_INFORMATIQUE]: [[LeboncoinAgent shareAgent] getCategoryName:SC_INFORMATIQUE]
                                ,[NSString stringWithFormat:@"%d",SC_MULTIMEDIA]: [[LeboncoinAgent shareAgent] getCategoryName:SC_MULTIMEDIA]
                                ,[NSString stringWithFormat:@"%d",SC_MUSIC]: [[LeboncoinAgent shareAgent] getCategoryName:SC_MUSIC]
                                ,[NSString stringWithFormat:@"%d",SC_TELEPHONE]: [[LeboncoinAgent shareAgent] getCategoryName:SC_TELEPHONE]
                                };
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self loadSearchCategoryDict];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tblSearchCategories reloadData];
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
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dictLBCSearchCategories.allKeys.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchCategoryCellId"];
    UILabel *lblCategoryTitle = nil;
    if (IS_OS_7_OR_LATER) {
        lblCategoryTitle = (UILabel*)[cell.contentView viewWithTag:kTagCategoryTitleLabel];
    } else {
        lblCategoryTitle = (UILabel*)[cell viewWithTag:kTagCategoryTitleLabel];
    }
    
    lblCategoryTitle.text = [dictLBCSearchCategories objectForKey:[dictLBCSearchCategories.allKeys objectAtIndex:indexPath.row]];
    
    if (self.handleSearchCondition && self.handleSearchCondition.searchCategory == ((NSNumber*)[dictLBCSearchCategories.allKeys objectAtIndex:indexPath.row]).intValue) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.handleSearchCondition) {
        self.handleSearchCondition.searchCategory = ((NSNumber*)[dictLBCSearchCategories.allKeys objectAtIndex:indexPath.row]).intValue;
    }
    [self.tblSearchCategories reloadData];
}

#pragma -

@end
