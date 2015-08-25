//
//  DetailViewController.h
//  RunningApp
//
//  Created by Boon Chia on 8/18/15.
//  Copyright (c) 2015 Matthias Chia. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>
#import <Social/Social.h>

@class Run;

@interface DetailViewController : UIViewController
{
}

@property (strong, nonatomic) Run *run;

-(IBAction)facebookPressed;

@end
