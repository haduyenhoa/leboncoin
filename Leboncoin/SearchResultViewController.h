//
//  MainViewController.h
//  Leboncoin
//
//  Created by Duyen Hoa Ha on 20/12/2013.
//  Copyright (c) 2013 Duyen Hoa Ha. All rights reserved.
//

#import "FlipsideViewController.h"
#import "FPPopoverController.h"
#import "ARCMacros.h"
#import "FPPopoverKeyboardResponsiveController.h"
#import "PKHPickerContainerView.h"

@interface SearchResultViewController : UIViewController <FlipsideViewControllerDelegate, UIPopoverControllerDelegate, UITableViewDataSource, UITableViewDelegate, FPPopoverControllerDelegate,UIPickerViewDataSource, UIPickerViewDelegate
, UISearchBarDelegate
> {
    
    NSMutableDictionary *dictResult;
    
    NSMutableDictionary *dictImage;
    
    FPPopoverKeyboardResponsiveController *popover;
}

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (strong, nonatomic) UIPopoverController *flipsidePopoverController;

@property (nonatomic) IBOutlet UITableView *tblSearch;

@property (nonatomic) IBOutlet UIButton *btnNext;
@property (nonatomic) IBOutlet UIButton *btnPrevious;

@property (nonatomic) IBOutlet UIButton *btnChangeSearchCondition;
@property (nonatomic) IBOutlet UILabel *lblSearchTitle;
@property (nonatomic) IBOutlet UISearchBar *sbCustomizedSearch;

@property (nonatomic) IBOutlet NSLayoutConstraint *constraintMainTable;

@property NSUInteger pageIndex;

@end
