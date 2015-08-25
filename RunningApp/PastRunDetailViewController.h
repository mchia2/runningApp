//
//  PastRunDetailViewController.h
//  RunningApp
//
//  Created by Boon Chia on 8/19/15.
//  Copyright (c) 2015 Matthias Chia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Run.h"

@interface PastRunDetailViewController : UIViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) Run *selectedRun;

-(IBAction)facebookPressed;

@end


