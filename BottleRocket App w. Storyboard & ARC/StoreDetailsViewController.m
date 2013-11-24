//
//  ViewController.m
//  BottleRocket App w. Storyboard & ARC
//
//  Created by John Andrews on 11/23/13.
//  Copyright (c) 2013 John Andrews. All rights reserved.
//

#import "StoreDetailsViewController.h"
#import "MapViewController.h"

@interface StoreDetailsViewController ()

@end

@implementation StoreDetailsViewController
@synthesize selectedSpecificStoreDetails, addressLabel, cityLabel, latitudeLabel, zipcodeLabel, phoneLabel,longitudeLabel, stateLabel, mapStoreAddressButtonOutlet, returnUserToAllStoresButtonOutlet;

- (void)viewDidLoad
{
    NSLog(@"please pass through %@", selectedSpecificStoreDetails);
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
    /*
    //Assign Store Values 
    addressLabel.text = [selectedSpecificStoreDetails objectForKey:@"address"];
    cityLabel.text = [selectedSpecificStoreDetails objectForKey:@"city"];
    latitudeLabel.text = @"41.8819"; //[selectedSpecificStoreDetails objectForKey:@"latitude"];
    zipcodeLabel.text = [selectedSpecificStoreDetails objectForKey:@"zipcode"];
    phoneLabel.text = [selectedSpecificStoreDetails objectForKey:@"phone"];
    longitudeLabel.text = @"-87.6278";//[selectedSpecificStoreDetails objectForKey:@"longitude"];
    stateLabel.text = [selectedSpecificStoreDetails objectForKey:@"state"]; */
}


- (void)assignIndividualStoreValues:(NSDictionary*)selectedStoreDictionary
{
    addressLabel.text = [selectedStoreDictionary objectForKey:@"address"];
    cityLabel.text = [selectedStoreDictionary objectForKey:@"city"];
    latitudeLabel.text = @"41.8819"; //[selectedSpecificStoreDetails objectForKey:@"latitude"];
    zipcodeLabel.text = [selectedStoreDictionary objectForKey:@"zipcode"];
    phoneLabel.text = [selectedStoreDictionary objectForKey:@"phone"];
    longitudeLabel.text = @"-87.6278";//[selectedSpecificStoreDetails objectForKey:@"longitude"];
    stateLabel.text = [selectedStoreDictionary objectForKey:@"state"];
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
