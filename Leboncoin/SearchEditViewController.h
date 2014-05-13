//
//  SearchEditViewController.h
//  Leboncoin
//
//  Created by Duyen Hoa Ha on 03/01/2014.
//  Copyright (c) 2014 Duyen Hoa Ha. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SearchCondition;
@interface SearchEditViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, assign) SearchCondition *handleSearchCondition;

@property (nonatomic) IBOutlet UITextField *tfSearchKey;
@property (nonatomic) IBOutlet UITextField *tfSearchTitle;
@property (nonatomic) IBOutlet UIButton *btnSearchCategory;
@property (nonatomic) IBOutlet UIButton *btnSearchLocation;
@property (nonatomic) IBOutlet UITextField *tfSearchCodePostal;
@property (nonatomic) IBOutlet UITextField *tfSearchMinPrice;
@property (nonatomic) IBOutlet UITextField *tfSearchMaxPrice;
@property (nonatomic) IBOutlet UITextField *tfSearchMinYear;
@property (nonatomic) IBOutlet UITextField *tfSearchMaxYear;

@end
