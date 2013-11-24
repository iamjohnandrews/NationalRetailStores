//
//  MapViewController.h
//  BottleRocket App w. Storyboard & ARC
//
//  Created by John Andrews on 11/23/13.
//  Copyright (c) 2013 John Andrews. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MapViewController : UIViewController


@property (weak, nonatomic) IBOutlet UIButton *dismissMapViewButtonOutlet;

- (IBAction)dismissMapViewButtonPressed:(id)sender;

@property (weak, nonatomic) IBOutlet MKMapView *storeMapView;

@property float storeLatitude;

@property float storeLongitude;

@end
