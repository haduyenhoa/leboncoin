//
//  MainPageViewController.h
//  Leboncoin
//
//  Created by Duyen Hoa Ha on 05/03/2014.
//  Copyright (c) 2014 Duyen Hoa Ha. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainPageViewController : UIViewController <UIPageViewControllerDataSource>

@property (strong, nonatomic) UIPageViewController *pageViewController;

-(void)jumpToPage:(int)pageIdx;

@end
