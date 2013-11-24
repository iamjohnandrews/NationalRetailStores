//
//  ViewController.m
//  BottleRocket App w. Storyboard & ARC
//
//  Created by John Andrews on 11/23/13.
//  Copyright (c) 2013 John Andrews. All rights reserved.
//

#import "StoreDetailsViewController.h"
#import "MapViewController.h"
#import <CoreData/CoreData.h>//could this be why instance is not recognized?

@interface StoreDetailsViewController ()

@end

@implementation StoreDetailsViewController
@synthesize selectedSpecificStoreDetails, addressLabel, cityLabel, latitudeLabel, zipcodeLabel, phoneLabel,longitudeLabel, stateLabel, mapStoreAddressButtonOutlet, returnUserToAllStoresButtonOutlet;

- (void)viewDidLoad
{
    //NSLog(@"please pass through %@", selectedSpecificStoreDetails);
    [super viewDidLoad];
	// Style Buttons
    returnUserToAllStoresButtonOutlet.layer.borderWidth = 2;
    returnUserToAllStoresButtonOutlet.layer.cornerRadius = 9;
    returnUserToAllStoresButtonOutlet.layer.borderColor = [[UIColor darkGrayColor] CGColor];
    returnUserToAllStoresButtonOutlet.layer.backgroundColor = [[UIColor lightGrayColor] CGColor];
    [returnUserToAllStoresButtonOutlet setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    mapStoreAddressButtonOutlet.layer.borderWidth = 2;
    mapStoreAddressButtonOutlet.layer.cornerRadius = 9;
    mapStoreAddressButtonOutlet.layer.borderColor = [[UIColor darkGrayColor] CGColor];
    mapStoreAddressButtonOutlet.layer.backgroundColor = [[UIColor lightGrayColor] CGColor];
    [mapStoreAddressButtonOutlet setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    //Assign Store Values 

}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"StoreDetailsToMapSegue"]) {
        MapViewController* mapView = [[MapViewController alloc] init];
        mapView.storeLatitude = [latitudeLabel.text floatValue];
        mapView.storeLongitude = [longitudeLabel.text floatValue];
        //NSLog(@"the corrdinates: latitude = %f, logitude = %f", mapView.storeLatitude, mapView.storeLongitude);
    }    
}

- (IBAction)mapStoreAddressButtonPressed:(id)sender 
{
    
}

- (IBAction)returnUserToAllStoresButtonPressed:(id)sender 
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
@end
