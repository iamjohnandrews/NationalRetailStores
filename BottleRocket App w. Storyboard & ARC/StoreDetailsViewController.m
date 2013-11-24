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
    NSString* tempString;
}

@end

@implementation StoreDetailsViewController
@synthesize selectedSpecificStoreDetails, addressLabel, cityLabel, latitudeLabel, zipcodeLabel, phoneLabel,longitudeLabel, stateLabel, mapStoreAddressButtonOutlet, storeLogoDisplayImage;

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    /*
	// Style Button    
    mapStoreAddressButtonOutlet.layer.borderWidth = 2;
    mapStoreAddressButtonOutlet.layer.cornerRadius = 9;
    mapStoreAddressButtonOutlet.layer.borderColor = [[UIColor darkGrayColor] CGColor];
    mapStoreAddressButtonOutlet.layer.backgroundColor = [[UIColor lightGrayColor] CGColor];
    [mapStoreAddressButtonOutlet setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    */
    //Assign Store Values 
    //UIImage* image = [UIImage imageNamed:[selectedSpecificStoreDetails objectForKey:@"storeLogoURL"]];
    //[self.storeLogoDisplayImage setImage:image];
    addressLabel.text = tempString;
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
    NSData *imageData  = [NSData dataWithContentsOfURL:url];
    NSLog(@"the stores number is %@", stores.phone);
    tempString = stores.phone ;
    addressLabel.text = stores.address;
    storeLogoDisplayImage.image = [UIImage imageWithData:imageData];
}

- (IBAction)mapStoreAddressButtonPressed:(id)sender 
{
    
}

@end
