//
//  SearchEditViewController.m
//  Leboncoin
//
//  Created by Duyen Hoa Ha on 03/01/2014.
//  Copyright (c) 2014 Duyen Hoa Ha. All rights reserved.
//

#import "SearchEditViewController.h"
#import "SearchCondition.h"
#import "LeboncoinAgent.h"

@interface SearchEditViewController () {
    int _searchCategory;
    int _searchLocation;
    
    SearchCondition *_newSearchCondition;
}

@end

@implementation SearchEditViewController

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
        _searchCategory = -1;
        _searchLocation = -1;
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
    
    self.navigationController.navigationBarHidden = NO;
    
    //refresh datas
    [self refresh];
}

//override
-(void)setHandleSearchCondition:(SearchCondition *)handleSearchCondition {
    if (handleSearchCondition == nil) {
        return;
    }
    _handleSearchCondition = handleSearchCondition;
    _searchCategory = _handleSearchCondition.searchCategory;
    _searchLocation = _handleSearchCondition.searchRegion;
    
}

-(void)refresh {
    if (self.handleSearchCondition == nil
        && _newSearchCondition == nil
        ) {
        return;
    }
    
    if (self.handleSearchCondition) {
        self.tfSearchKey.text = self.handleSearchCondition.searchKey;
        self.tfSearchTitle.text = self.handleSearchCondition.searchTitle;
        [self.btnSearchCategory setTitle:[[LeboncoinAgent shareAgent] getCategoryName:self.handleSearchCondition.searchCategory] forState:UIControlStateNormal];
        [self.btnSearchCategory setTitle:[[LeboncoinAgent shareAgent] getCategoryName:self.handleSearchCondition.searchCategory] forState:UIControlStateSelected];
        
        [self.btnSearchLocation setTitle:[[LeboncoinAgent shareAgent] getLocationName:self.handleSearchCondition.searchRegion] forState:UIControlStateNormal];
        [self.btnSearchLocation setTitle:[[LeboncoinAgent shareAgent] getLocationName:self.handleSearchCondition.searchRegion] forState:UIControlStateSelected];
        
        if (self.handleSearchCondition.searchCodePostal > 0) {
            self.tfSearchCodePostal.text = [NSString stringWithFormat:@"%d",self.handleSearchCondition.searchCodePostal];
        } else {
            self.tfSearchCodePostal.text = @"";
        }
    } else {
        self.tfSearchKey.text = _newSearchCondition.searchKey;
        self.tfSearchTitle.text = _newSearchCondition.searchTitle;
        [self.btnSearchCategory setTitle:[[LeboncoinAgent shareAgent] getCategoryName:_newSearchCondition.searchCategory] forState:UIControlStateNormal];
        [self.btnSearchCategory setTitle:[[LeboncoinAgent shareAgent] getCategoryName:_newSearchCondition.searchCategory] forState:UIControlStateSelected];
        
        [self.btnSearchLocation setTitle:[[LeboncoinAgent shareAgent] getLocationName:_newSearchCondition.searchRegion] forState:UIControlStateNormal];
        [self.btnSearchLocation setTitle:[[LeboncoinAgent shareAgent] getLocationName:_newSearchCondition.searchRegion] forState:UIControlStateSelected];
        
        if (self.handleSearchCondition.searchCodePostal > 0) {
            self.tfSearchCodePostal.text = [NSString stringWithFormat:@"%d",_newSearchCondition .searchCodePostal];
        } else {
            self.tfSearchCodePostal.text = @"";
        }
    }

    
}

#pragma mark TextViewDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}
#pragma -

-(IBAction)saveSearchCondition:(id)sender {

    if (self.tfSearchTitle.text == nil || [self.tfSearchTitle.text isEqualToString:@""]) {
        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Please enter search title" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
        return;
    }
    
    if (_searchCategory < 0) {
        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Please select a category" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
        return;
    }
    
    if (_searchLocation < 0) {
        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Please select search region" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
        return;
    }
    
    if (self.handleSearchCondition == nil) {
        if (_newSearchCondition == nil) {
            _newSearchCondition = [[SearchCondition alloc] init];
        }
        
        
        //add to LeboncoinAgent
        [LeboncoinAgent shareAgent].searchConditions = [[LeboncoinAgent shareAgent].searchConditions arrayByAddingObject:_newSearchCondition];
        
        [self setHandleSearchCondition:_newSearchCondition];
    }
    
    self.handleSearchCondition.searchRegion = _searchLocation;
    self.handleSearchCondition.searchCategory = _searchCategory;
    self.handleSearchCondition.searchKey = self.tfSearchKey.text;
    self.handleSearchCondition.searchTitle = self.tfSearchTitle.text;
    self.handleSearchCondition.searchCodePostal = self.tfSearchCodePostal.text.intValue;
    
    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"leboncoin.xml"];
    
    [[LeboncoinAgent shareAgent] saveSearchConditions:[LeboncoinAgent shareAgent].searchConditions toFile:filePath];
}

-(IBAction)showLocationChoices:(id)sender {
    
}

-(IBAction)showCategoryChoice:(id)sender {
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"SelectSearchCategoryId"]) {
        if (self.handleSearchCondition ==nil) {
            if (_newSearchCondition == nil) {
                _newSearchCondition = [[SearchCondition alloc] init];
            }
            
            [segue.destinationViewController setHandleSearchCondition:_newSearchCondition];
        } else {
        [segue.destinationViewController setHandleSearchCondition:self.handleSearchCondition];
        }
            
        
    } else if ([segue.identifier isEqualToString:@"SelectSearchRegionId"]) {
        if (self.handleSearchCondition ==nil) {
            if (_newSearchCondition == nil) {
                _newSearchCondition = [[SearchCondition alloc] init];
            }
            
            [segue.destinationViewController setHandleSearchCondition:_newSearchCondition];
        } else {
            [segue.destinationViewController setHandleSearchCondition:self.handleSearchCondition];
        }
    }
}
@end
