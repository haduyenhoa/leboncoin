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

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate, UIPopoverControllerDelegate, UITableViewDataSource, UITableViewDelegate, FPPopoverControllerDelegate> {
    
    NSMutableDictionary *dictResult;
    
    int currentIndex;
    
    NSMutableDictionary *dictImage;
    
    FPPopoverKeyboardResponsiveController *popover;
}

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (strong, nonatomic) UIPopoverController *flipsidePopoverController;

@property (nonatomic) IBOutlet UITableView *tblSearch;

@property (nonatomic) IBOutlet UIButton *btnNext;
@property (nonatomic) IBOutlet UIButton *btnPrevious;

@end
