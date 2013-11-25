//
//  ViewController.m
//  BottleRocket App w. Storyboard & ARC
//
//  Created by John Andrews on 11/23/13.
//  Copyright (c) 2013 John Andrews. All rights reserved.
//

#import "StoreDetailsViewController.h"
#import "MapViewController.h"
#import "Stores.h"
#import "AppDelegate.h"

@interface StoreDetailsViewController ()
{
    NSArray* pulledFromCoreDataArray;
    NSData *imageData;
    
    NSString* tempString;
    NSString* tempString2;
    NSString* tempString3;
    NSString* tempString4;
    NSString* tempString5;
    NSString* tempString6;
    NSString* tempString7;
    NSString* tempString8;
}

@end

@implementation StoreDetailsViewController
@synthesize selectedSpecificStoreDetails, addressLabel, cityLabel, latitudeLabel, zipcodeLabel, phoneLabel,longitudeLabel, stateLabel, mapStoreAddressButtonOutlet, storeLogoDisplayImage;

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
	// Style Button    
    mapStoreAddressButtonOutlet.layer.borderWidth = 2;
    mapStoreAddressButtonOutlet.layer.cornerRadius = 9;
    mapStoreAddressButtonOutlet.layer.borderColor = [[UIColor darkGrayColor] CGColor];
    mapStoreAddressButtonOutlet.layer.backgroundColor = [[UIColor orangeColor] CGColor];
    [mapStoreAddressButtonOutlet setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    //Assign Store Values 
    storeLogoDisplayImage.image = [UIImage imageWithData:imageData];
    phoneLabel.text = tempString;
    addressLabel.text = tempString2;
    cityLabel.text = tempString3;
    stateLabel.text = tempString4;
    zipcodeLabel.text = tempString5;
    latitudeLabel.text = tempString6;
    longitudeLabel.text = tempString7;
}

- (void)fetchFromCoreData:(NSInteger)selectedRow
{
    //Fetch from Core Data
    NSManagedObjectContext* moc = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    NSEntityDescription* entityDescription = [NSEntityDescription entityForName:@"Stores" inManagedObjectContext:moc];
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
    NSFetchedResultsController* fetchResultsController;
    NSError* error;
    NSSortDescriptor* sortDescriptor;
    NSArray* sortDescriptors;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"address" ascending:YES];
    sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    fetchRequest.entity = entityDescription;
    fetchRequest.sortDescriptors = sortDescriptors;
    fetchResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:moc sectionNameKeyPath:nil cacheName:nil];
    [fetchResultsController performFetch:&error];
    
    pulledFromCoreDataArray = fetchResultsController.fetchedObjects;
    
    Stores* stores = [pulledFromCoreDataArray objectAtIndex:selectedRow];
    
    NSURL *url = [NSURL URLWithString:stores.storeLogoURL];
    imageData  = [NSData dataWithContentsOfURL:url];
    
    tempString = stores.phone ;
    tempString2 = stores.address;
    tempString3 = stores.city;
    tempString4 = stores.state;
    tempString5 = stores.zipcode;
    tempString6 = stores.latitude;
    tempString7 = stores.longitude;  
    tempString8 = stores.name;
}

- (IBAction)mapStoreAddressButtonPressed:(id)sender 
{
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"StoreDetailsToMapSegue"]) {
        MapViewController* mvc = segue.destinationViewController;
        mvc.storeLatitude = [tempString6 floatValue];
        mvc.storeLongitude = [tempString7 floatValue];
        mvc.storename = tempString8;
    }
        
}

@end
