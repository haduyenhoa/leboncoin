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
@interface AnnonceDetailViewController : UIViewController <UIAlertViewDelegate>{
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


- (void)imageClicked:(UIGestureRecognizer *)gesture;
@end
