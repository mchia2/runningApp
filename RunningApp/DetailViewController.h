//
//  DetailViewController.h
//  RunningApp
//
//  Created by Boon Chia on 8/18/15.
//  Copyright (c) 2015 Matthias Chia. All rights reserved.
//

//#import <UIKit/UIKit.h>
//
//@interface DetailViewController : UIViewController
//
//@property (strong, nonatomic) id detailItem;
//@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
//
//@end

#import <UIKit/UIKit.h>

@class Run;

@interface DetailViewController : UIViewController

@property (strong, nonatomic) Run *run;

@end
