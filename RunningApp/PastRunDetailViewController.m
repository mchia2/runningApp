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
#import "Social/Social.h"
#import <MapKit/MapKit.h>

@interface PastRunDetailViewController () 
@property (weak, nonatomic) IBOutlet UILabel *distance;
@property (weak, nonatomic) IBOutlet UILabel *date;

@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *pace;

@property (weak, nonatomic) IBOutlet UIButton *facebook;
@property (nonatomic, weak) IBOutlet MKMapView *mapView;

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
    
    [self loadMap];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (MKCoordinateRegion)mapRegion
{
    MKCoordinateRegion region;
    Location *initialLoc = self.selectedRun.locations.firstObject;
    
    float minLat = initialLoc.latitude.floatValue;
    float minLng = initialLoc.longtitude.floatValue;
    float maxLat = initialLoc.latitude.floatValue;
    float maxLng = initialLoc.longtitude.floatValue;
    
    for (Location *location in self.selectedRun.locations) {
        if (location.latitude.floatValue < minLat) {
            minLat = location.latitude.floatValue;
        }
        if (location.longtitude.floatValue < minLng) {
            minLng = location.longtitude.floatValue;
        }
        if (location.latitude.floatValue > maxLat) {
            maxLat = location.latitude.floatValue;
        }
        if (location.longtitude.floatValue > maxLng) {
            maxLng = location.longtitude.floatValue;
        }
    }
    
    region.center.latitude = (minLat + maxLat) / 2.0f;
    region.center.longitude = (minLng + maxLng) / 2.0f;
    
    region.span.latitudeDelta = (maxLat - minLat) * 1.1f; // 10% padding
    region.span.longitudeDelta = (maxLng - minLng) * 1.1f; // 10% padding
    
    return region;
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id < MKOverlay >)overlay
{
    if ([overlay isKindOfClass:[MKPolyline class]]) {
        MKPolyline *polyLine = (MKPolyline *)overlay;
        MKPolylineRenderer *aRenderer = [[MKPolylineRenderer alloc] initWithPolyline:polyLine];
        aRenderer.strokeColor = [UIColor blackColor];
        aRenderer.lineWidth = 3;
        return aRenderer;
    }
    
    return nil;
}

- (MKPolyline *)polyLine {
    
    CLLocationCoordinate2D coords[self.selectedRun.locations.count];
    
    for (int i = 0; i < self.selectedRun.locations.count; i++) {
        Location *location = [self.selectedRun.locations objectAtIndex:i];
        coords[i] = CLLocationCoordinate2DMake(location.latitude.doubleValue, location.longtitude.doubleValue);
    }
    
    return [MKPolyline polylineWithCoordinates:coords count:self.selectedRun.locations.count];
}

- (void)loadMap
{
    if (self.selectedRun.locations.count > 0) {
        
        self.mapView.hidden = NO;
        
        // set the map bounds
        [self.mapView setRegion:[self mapRegion]];
        
        // make the line(s!) on the map
        [self.mapView addOverlay:[self polyLine]];
        
    } else {
        
        // no locations were found!
        self.mapView.hidden = YES;
        
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Error"
                                  message:@"Sorry, this run has no locations saved."
                                  delegate:nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }
}


-(IBAction)facebookPressed{
    
    CGRect rect = CGRectMake(0, 0, 380, 600);
    UIGraphicsBeginImageContext(rect.size);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *screengrab = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]){
        SLComposeViewController *message = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        message = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        [message setInitialText:@"Check out how much I ran today!"];
        [message addImage:screengrab];
        [self presentViewController:message animated:YES completion:nil];
    }
}


@end
