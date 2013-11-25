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
@synthesize storeLongitude, storeLatitude, storeMapView, storename;

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
	
    NSLog(@"the corrdinates of %@: latitude = %f, logitude = %f", storename, storeLatitude, storeLongitude);
}

- (void) viewDidAppear:(BOOL)animated
{
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(storeLatitude, storeLongitude);
    MKCoordinateSpan span = MKCoordinateSpanMake(0.01, 0.02);
    [self.storeMapView setRegion:MKCoordinateRegionMake(coord, span) animated:YES];
    
    MKPointAnnotation* dropPin = [[MKPointAnnotation alloc] init];
    [dropPin setCoordinate:coord];
    [dropPin setTitle:storename];   
    [self.storeMapView addAnnotation:dropPin];
}


@end
