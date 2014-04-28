//
//  SettingsViewController.m
//  Leboncoin
//
//  Created by Duyen Hoa Ha on 29/04/2014.
//  Copyright (c) 2014 Duyen Hoa Ha. All rights reserved.
//

#import "SettingsViewController.h"
#import "LeboncoinAgent.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)updateViaDropBox:(id)sender {
    
    NSString *dropBoxLink = @"https://dl.dropboxusercontent.com/s/fau2t681lydkl29/leboncoin.xml?dl=1";
    NSString *libraryPath = [[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"leboncoin.xml"];
    
    NSString *remoteContent = [NSString stringWithContentsOfURL:[NSURL URLWithString:dropBoxLink] encoding:NSUTF8StringEncoding error:nil];
    if (remoteContent) {
        NSString *tempFilePath = [[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"tempLeboncoin.xml"];
        if ([[NSFileManager defaultManager] fileExistsAtPath:tempFilePath isDirectory:nil]) {
            [[NSFileManager defaultManager] removeItemAtPath:tempFilePath error:nil];
        }
        
        [[NSFileManager defaultManager] moveItemAtPath:libraryPath toPath:tempFilePath error:nil];
        if ([remoteContent writeToFile:libraryPath atomically:YES encoding:NSUTF8StringEncoding error:nil]) {
            NSLog(@"write new file from drop box OK");
            [[NSFileManager defaultManager] removeItemAtPath:tempFilePath error:nil];
        }
        
        [[LeboncoinAgent shareAgent] getSearchConditionsFromFile:libraryPath];
    } else {
        NSLog(@"cannot get content at %@ ",dropBoxLink);
    }
        
    

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
