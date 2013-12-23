//
//  AnnonceDetailViewController.m
//  Leboncoin
//
//  Created by Duyen Hoa Ha on 22/12/2013.
//  Copyright (c) 2013 Duyen Hoa Ha. All rights reserved.
//

#import "AnnonceDetailViewController.h"

@interface AnnonceDetailViewController ()

@end

@implementation AnnonceDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //load content in background
    [self performSelectorInBackground:@selector(loadContent) withObject:nil];
}

-(void)loadContent {
    if (self.myAnnonce == nil || self.myAnnonce.linkAnnonce == nil) {
        NSLog(@"this annonce does not have link");
        return;
    }
    
    //load content
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
