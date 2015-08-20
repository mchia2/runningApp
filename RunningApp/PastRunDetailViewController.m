//
//  PastRunDetailViewController.m
//  RunningApp
//
//  Created by Boon Chia on 8/19/15.
//  Copyright (c) 2015 Matthias Chia. All rights reserved.
//

#import "PastRunDetailViewController.h"
#import "AppDelegate.h"
#import "MathController.h"
#import "Run.h"
#import "Location.h"

@interface PastRunDetailViewController () 
@property (weak, nonatomic) IBOutlet UILabel *distance;
@property (weak, nonatomic) IBOutlet UILabel *date;

@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *pace;


@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end

@implementation PastRunDetailViewController

//@synthesize viewRun;

- (void)setRun:(Run *)run
{
    if (_selectedRun != run) {
        _selectedRun = run;
        [self configureView];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//allows you to refer to managedObjectContext as self

-(NSManagedObjectContext*)managedObjectContext{
    return [(AppDelegate*)[[UIApplication sharedApplication]delegate]managedObjectContext];
}

- (void)configureView
{
    self.distance.text = [MathController stringifyDistance:self.selectedRun.distance.floatValue];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    self.date.text = [formatter stringFromDate:self.selectedRun.timestamp];
    
    self.time.text = [NSString stringWithFormat:@"Time: %@",  [MathController stringifySecondCount:self.selectedRun.duration.intValue usingLongFormat:YES]];
    
    self.pace.text = [NSString stringWithFormat:@"Pace: %@",  [MathController stringifyAvgPaceFromDist:self.selectedRun.distance.floatValue overTime:self.selectedRun.duration.intValue]];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
