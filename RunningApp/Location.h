//
//  Location.h
//  RunningApp
//
//  Created by Boon Chia on 8/18/15.
//  Copyright (c) 2015 Matthias Chia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class NSManagedObject;

@interface Location : NSManagedObject

@property (nonatomic, retain) NSDate * timestamp;
@property (nonatomic, retain) NSNumber * longtitude;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSManagedObject *run;

@end
