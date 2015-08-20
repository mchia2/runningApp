//
//  PastRunsTableViewController.h
//  
//
//  Created by Boon Chia on 8/19/15.
//
//

#import <UIKit/UIKit.h>
#import "Run.h"

@interface PastRunsTableViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) Run *run;


@end
