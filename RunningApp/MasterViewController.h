//
//  MasterViewController.h
//  RunningApp
//
//  Created by Boon Chia on 8/18/15.
//  Copyright (c) 2015 Matthias Chia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface MasterViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;


@end

