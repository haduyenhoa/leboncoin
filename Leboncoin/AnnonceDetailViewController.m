//
//  AnnonceDetailViewController.m
//  Leboncoin
//
//  Created by Duyen Hoa Ha on 22/12/2013.
//  Copyright (c) 2013 Duyen Hoa Ha. All rights reserved.
//

#import "AnnonceDetailViewController.h"
#import "LeboncoinAgent.h"
#import <QuartzCore/QuartzCore.h>
#import "MHFacebookImageViewer.h"
#import <iAd/iAd.h>

@interface AnnonceDetailViewController ()

@end

@implementation AnnonceDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        imageArrays = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.wvAnnonceContents.layer.borderWidth = 1;
    self.wvAnnonceContents.layer.borderColor = [UIColor darkGrayColor].CGColor;
    self.canDisplayBannerAds = YES;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

-(void)viewDidAppear:(BOOL)animated {
    NSLog(@"%s",__FUNCTION__);
    [super viewDidAppear:animated];
    
    self.scrvImages.pagingEnabled = YES;
    [self.scrvImages setAlwaysBounceVertical:NO];
    
    NSArray *subViews = self.scrvImages.subviews;
    for (UIView *subview in subViews) {
        [subview removeFromSuperview];
    }
    subViews = nil;
    
    //load content in background
//    [self performSelectorInBackground:@selector(loadContent) withObject:nil];
    [self hideSendEmail:nil];
}

-(IBAction)sendMessageToSeller:(id)sender
{
   BOOL sent =  [[LeboncoinAgent shareAgent] sendEmail:self.tvMessage.text toAnnonce:self.myAnnonce fromEmail:self.tfEmail.text fromName:self.tfName.text fromTelephone:self.tfPhone.text];
    
    if (sent) {
        [[[UIAlertView alloc] initWithTitle:@"Info" message:@"Message sent" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
    } else {
        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Cannot send message" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
    }
}

-(IBAction)showSendEmail:(id)sender
{
    [UIView beginAnimations:@"test1" context:nil];
    [UIView setAnimationDuration:0.5];
    self.constraintHeightSendMail.constant = 160;
    [UIView commitAnimations];
    
    [UIView beginAnimations:@"test2" context:nil];
    [UIView setAnimationDuration:0.5];
    self.vSendMail.alpha = 1.0;
    [UIView commitAnimations];

    [self performSelectorInBackground:@selector(loadContent) withObject:nil];
}

-(IBAction)hideSendEmail:(id)sender
{
    [UIView beginAnimations:@"test2" context:nil];
    [UIView setAnimationDuration:0.2];
    self.vSendMail.alpha = 0.0;
    [UIView commitAnimations];
    
    [UIView beginAnimations:@"test1" context:nil];
    [UIView setAnimationDuration:0.5];
    self.constraintHeightSendMail.constant = 0;
    [UIView commitAnimations];
    
    [self performSelectorInBackground:@selector(loadContent) withObject:nil];
}

-(void)loadContent {
    if (self.myAnnonce == nil || self.myAnnonce.linkAnnonce == nil) {
        NSLog(@"this annonce does not have link");
        return;
    }
    
    if (imageArrays == nil) {
        imageArrays = [[NSMutableArray alloc] init];
    }
    [imageArrays removeAllObjects];
    
    //load content
    myAnnonceDetail = [[LeboncoinAgent shareAgent] getAnnonceDetailFromJson:self.myAnnonce];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *htmlTitle = [NSString stringWithFormat:@"<html><body style=\"font-size:18px;\"><div align=\"center\"><b>%@</b></div></body></html>", myAnnonceDetail.title];
        
        self.tvTitle.attributedText = [[NSAttributedString alloc] initWithData:[htmlTitle dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
        
        NSString *html = [NSString stringWithFormat:@"<html><body style=\"font-size:16px;\">%@</body></html>",myAnnonceDetail.text];
        NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[html dataUsingEncoding:NSUTF8StringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
        
        float contentSize = [attributedString size].height;
        
        NSLog(@"resize frame to %0.2f",contentSize);
        float originalX = 4;
        float originalY = 200;
        float width = 292;
        UITextView *tv = [[UITextView alloc] initWithFrame:CGRectMake(originalX, originalY, width, contentSize)];
        tv.attributedText = attributedString;
        tv.editable = NO;
        [tv setScrollEnabled:NO];
        [tv sizeToFit];
        [tv layoutIfNeeded];
        
        [self.scrvAnnonce addSubview:tv];
        
        [self.scrvAnnonce setContentSize:CGSizeMake(self.scrvAnnonce.contentSize.width, originalY + tv.frame.size.height)];
        
//        [self.wvAnnonceContents loadHTMLString:html baseURL:nil];
    });

    dispatch_async(dispatch_get_main_queue(), ^{
        if (myAnnonceDetail.telephoneNumber!= nil && ![myAnnonceDetail.telephoneNumber isEqualToString:@""]) {
            [self.btnCall setTitle:myAnnonceDetail.telephoneNumber];
            [self.btnCall setEnabled:YES];
        } else {
            [self.btnCall setEnabled:NO];
        }
        
        NSString *cityInfo = [NSString stringWithFormat:@"%@ (%@)", myAnnonceDetail.postalCode == nil ? @"" : myAnnonceDetail.postalCode, myAnnonceDetail.ville == nil? @"" : myAnnonceDetail.ville];
        self.lblCity.text = cityInfo;

        if (myAnnonceDetail.priceString) {
            [self.btnPrice setTitle:[NSString stringWithFormat:@"%@",myAnnonceDetail.priceString]];
        } else {
            [self.btnPrice setTitle:[NSString stringWithFormat:@"- €"]];
        }
    });
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (myAnnonceDetail.imgPhoneNumber) {
            self.ivPhoneNumber.image = myAnnonceDetail.imgPhoneNumber;
        } else {
            self.ivPhoneNumber.image = nil;
        }
    });
    
    dispatch_async(dispatch_queue_create("fr.leboncoin.image", DISPATCH_QUEUE_PRIORITY_DEFAULT), ^{
        
        for (NSString *linkImage in myAnnonceDetail.imageLink) {
            NSLog(@"download image: %@",linkImage);
            
            UIImage *img = [UIImage imageWithData:[NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:linkImage]] returningResponse:nil error:nil]];
            
            if (img) {
                [imageArrays addObject:img];
                [self performSelectorOnMainThread:@selector(refreshImages:) withObject:img waitUntilDone:NO];
            } else {
                NSLog(@"cannot download image");
            }
            
        }
    });
    

}

-(void)refreshImages:(UIImage*)newImage {
    if (newImage == nil) {
        //Do nothing
        return;
    }
    
    if (![NSThread isMainThread]) {
        [self performSelectorOnMainThread:@selector(refreshImages:) withObject:newImage waitUntilDone:NO];
        return;
    }
    
    @synchronized(self) {
        if (imageArrays.count == 0) {
            NSLog(@"%s: does not have image",__func__);
            return;
        }
        
        float imageWidth = 200;
        float offSet = 10;
        NSUInteger imageIdx = self.scrvImages.subviews.count;
        
        //set image to scroll view
        UIImageView *image = [[UIImageView alloc] initWithFrame:
                              CGRectMake((imageWidth + offSet) * imageIdx++, 0,
                                         imageWidth,
                                         self.scrvImages.frame.size.height)];
        [image setImage:newImage];
        image.contentMode = UIViewContentModeScaleAspectFit;
        [image setupImageViewer];
        
        [self.scrvImages addSubview:image];
        
        self.scrvImages.contentSize = CGSizeMake((imageWidth +offSet)* imageIdx,
                                                 self.scrvImages.frame.size.height);
    }
    
}

-(IBAction)callSeller:(id)sender {
    if (myAnnonceDetail && myAnnonceDetail.telephoneNumber) {
        [[[UIAlertView alloc] initWithTitle:@"Appeler vendeur" message:[NSString stringWithFormat:@"Sure to call: %@ ?", myAnnonceDetail.telephoneNumber] delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil] show];
    }
}

-(IBAction)showMaps:(id)sender {
    NSString* addr = [NSString stringWithFormat:@"comgooglemaps://maps.google.com/maps?q=%@&views=traffic",myAnnonceDetail.postalCode];
    NSURL* url = [[NSURL alloc] initWithString:[addr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [[UIApplication sharedApplication] openURL:url];
}

-(void)callNow {
    if (myAnnonceDetail && myAnnonceDetail.telephoneNumber) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", myAnnonceDetail.telephoneNumber]]];
    }
}

- (void)imageClicked:(UIGestureRecognizer *)gesture {
    NSLog(@"");
}

#pragma mark UIAlertView
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [self callNow];
    }
}
#pragma -


#pragma mark UITextField
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}
#pragma -

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
