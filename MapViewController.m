//
//  MapViewController.m
//  BottleRocket App w. Storyboard & ARC
//
//  Created by John Andrews on 11/23/13.
//  Copyright (c) 2013 John Andrews. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MapViewController ()

@end

@implementation MapViewController
@synthesize storeLongitude, storeLatitude, storeMapView;

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
	
    NSLog(@"the corrdinates: latitude = %f, logitude = %f", storeLatitude, storeLongitude);
}

- (void) viewDidAppear:(BOOL)animated
{
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(storeLatitude, storeLongitude);
    MKCoordinateSpan span = MKCoordinateSpanMake(0.1, 0.2);
    [self.storeMapView setRegion:MKCoordinateRegionMake(coord, span) animated:YES];
    
}

@end
