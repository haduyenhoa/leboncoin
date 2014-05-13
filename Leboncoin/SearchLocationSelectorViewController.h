//
//  SearchLocationSelectorViewController.h
//  Leboncoin
//
//  Created by Duyen Hoa Ha on 01/05/2014.
//  Copyright (c) 2014 Duyen Hoa Ha. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SearchCondition;
@interface SearchLocationSelectorViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) IBOutlet UITableView *tblSearchLocations;
@property (nonatomic, assign) SearchCondition *handleSearchCondition;

@end
