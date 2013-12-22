//
//  MainViewController.h
//  Leboncoin
//
//  Created by Duyen Hoa Ha on 20/12/2013.
//  Copyright (c) 2013 Duyen Hoa Ha. All rights reserved.
//

#import "FlipsideViewController.h"

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate, UIPopoverControllerDelegate, UITableViewDataSource, UITableViewDelegate> {
    
    NSArray *listSearchCondition;
    
    NSMutableDictionary *dictResult;
    
    NSMutableDictionary *dictImage;
}

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (strong, nonatomic) UIPopoverController *flipsidePopoverController;

@property (nonatomic) IBOutlet UITableView *tblSearch;

@end
