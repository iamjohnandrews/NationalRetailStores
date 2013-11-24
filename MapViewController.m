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
@synthesize dismissMapViewButtonOutlet, storeLongitude, storeLatitude, storeMapView;

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
	// Do any additional setup after loading the view.
    dismissMapViewButtonOutlet.layer.borderWidth = 2;
    dismissMapViewButtonOutlet.layer.cornerRadius = 9;
    dismissMapViewButtonOutlet.layer.borderColor = [[UIColor whiteColor] CGColor];
    dismissMapViewButtonOutlet.layer.backgroundColor = [[UIColor orangeColor] CGColor];
    [dismissMapViewButtonOutlet setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    NSLog(@"the corrdinates: latitude = %f, logitude = %f", storeLatitude, storeLongitude);
}

- (void) viewDidAppear:(BOOL)animated
{
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(storeLatitude, storeLongitude);
    MKCoordinateSpan span = MKCoordinateSpanMake(0.1, 0.2);
    [self.storeMapView setRegion:MKCoordinateRegionMake(coord, span) animated:YES];
    
}

- (IBAction)dismissMapViewButtonPressed:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
