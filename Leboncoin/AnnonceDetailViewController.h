//
//  AnnonceDetailViewController.h
//  Leboncoin
//
//  Created by Duyen Hoa Ha on 22/12/2013.
//  Copyright (c) 2013 Duyen Hoa Ha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Annonce.h"
#import "AnnonceDetail.h"
@interface AnnonceDetailViewController : UIViewController <UIAlertViewDelegate, UITextFieldDelegate>{
    AnnonceDetail *myAnnonceDetail;
    
    NSMutableArray *imageArrays;
}

@property (nonatomic) Annonce *myAnnonce;

@property (nonatomic) IBOutlet UIWebView *wvAnnonceContents;
@property (nonatomic) IBOutlet UIView *vAnnonceDetails;
@property (nonatomic) IBOutlet UIImageView *ivPhoneNumber;

@property (nonatomic) IBOutlet UIBarButtonItem *btnCall;
@property (nonatomic) IBOutlet UIBarButtonItem *btnPrice;
@property (nonatomic) IBOutlet UIBarButtonItem *btnEmail;

@property (nonatomic) IBOutlet UITextView *tvAnnonceDetail;
@property (nonatomic) IBOutlet UIScrollView *scrvImages;
@property (nonatomic) IBOutlet UIScrollView *scrvAnnonce;
@property (nonatomic) IBOutlet UITextView *tvTitle;
@property (nonatomic) IBOutlet UIButton *btnShowMaps;
@property (nonatomic) IBOutlet UILabel *lblCity;

@property (nonatomic) IBOutlet UILabel *lblSellerName;
@property (nonatomic) IBOutlet UIButton *btnCallInDetail;

@property (nonatomic) IBOutlet UIView *vSendMail;
@property (nonatomic) IBOutlet UIButton *btnSendMessage;
@property (nonatomic) IBOutlet UIButton *hideSendMail;
@property (nonatomic) IBOutlet UITextView *tvMessage;
@property (nonatomic) IBOutlet UITextField *tfName;
@property (nonatomic) IBOutlet UITextField *tfPhone;
@property (nonatomic) IBOutlet UITextField *tfEmail;
@property (nonatomic) IBOutlet NSLayoutConstraint *constraintHeightSendMail;

- (void)imageClicked:(UIGestureRecognizer *)gesture;


@end
