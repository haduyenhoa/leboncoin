//
//  SearchManagerViewController.h
//  Leboncoin
//
//  Created by Duyen Hoa Ha on 03/01/2014.
//  Copyright (c) 2014 Duyen Hoa Ha. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchManagerViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) IBOutlet UITableView *tblSearchConditions;

@end
