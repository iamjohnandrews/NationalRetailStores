//
//  AllStoresViewController.m
//  BottleRocket App w. Storyboard & ARC
//
//  Created by John Andrews on 11/23/13.
//  Copyright (c) 2013 John Andrews. All rights reserved.
//

#import "AllStoresViewController.h"
#import "AppDelegate.h"
#import "Stores.h"
#import "StoreDetailsViewController.h"
#import "StoreSumDisplayCell.h"


@interface AllStoresViewController ()
{
    NSDictionary* dictionaryOuterLayer1;
    NSArray* arrayMidleLayer2;
    NSDictionary* dictionaryInnerLayer3;
    
    NSArray* allRetailStores;
    NSDictionary* passThroughDictionary;
    
    NSFileManager *fileManager;
    NSURL *documentsDirectory;
}
@end

@implementation AllStoresViewController
@synthesize storeSummariesTableView;

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        fileManager = [NSFileManager defaultManager];
        documentsDirectory = [[fileManager URLsForDirectory:NSDocumentDirectory
                                                  inDomains:NSUserDomainMask] lastObject];
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    NSManagedObjectContext* moc = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"hasData"])
    {
        NSURLRequest* urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://strong-earth-32.heroku.com/stores.aspx"]];
        
        [NSURLConnection sendAsynchronousRequest:urlRequest
                                           queue:[NSOperationQueue currentQueue]
                               completionHandler:
         ^(NSURLResponse* response, NSData* data, NSError* error)
         {
             dictionaryOuterLayer1 = [NSJSONSerialization JSONObjectWithData:data
                                                                 options:0
                                                                   error:&error];
             arrayMidleLayer2 = [[NSArray alloc] initWithArray:[dictionaryOuterLayer1 objectForKey:@"stores"]];
             
             for (dictionaryInnerLayer3 in arrayMidleLayer2) {
                 NSURL *url = [NSURL URLWithString:[dictionaryInnerLayer3 valueForKey:@"storeLogoURL"]];
                 NSString *imageFileName = [[url pathComponents] lastObject];
                 NSURL *localImageUrl = [documentsDirectory URLByAppendingPathComponent:imageFileName];
                 
                 NSData *imageData  = [NSData dataWithContentsOfURL:url];
                 [imageData writeToURL:localImageUrl atomically:YES];
                 
                 //Below is where you connect with core data
                 Stores* stores = [NSEntityDescription insertNewObjectForEntityForName:@"Stores" inManagedObjectContext:moc]; //this is the line that puts new hero into CoreData
                 stores.address = [dictionaryInnerLayer3 objectForKey:@"address"];
                 stores.city = [dictionaryInnerLayer3 objectForKey:@"city"];
                 stores.name = [dictionaryInnerLayer3 objectForKey:@"name"];
                 stores.latitude = [dictionaryInnerLayer3 objectForKey:@"latitude"];
                 stores.zipcode = [dictionaryInnerLayer3 objectForKey:@"zipcode"];
                 stores.phone = [dictionaryInnerLayer3 objectForKey:@"phone"];
                 stores.longitude = [dictionaryInnerLayer3 objectForKey:@"longitude"];
                 stores.storeID = [dictionaryInnerLayer3 objectForKey:@"storeID"];
                 stores.state = [dictionaryInnerLayer3 objectForKey:@"state"];
                 stores.storeLogoURL = localImageUrl.absoluteString;
             }
             
             NSError* superBadError;
             if (![moc save:&superBadError]) { //where you save to core data
                 NSLog(@"Failed to save because %@", superBadError);
             }
             
             [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"hasData"];
             [[NSUserDefaults standardUserDefaults] synchronize];
             
             [self fetchFromCoreData];
             [storeSummariesTableView reloadData];
         }];
        
    }
    else{
        [self fetchFromCoreData];
    }
}

- (void)fetchFromCoreData //where you load data
{
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
    
    allRetailStores = fetchResultsController.fetchedObjects;
    
    //NSLog(@"Errors are %@", error);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return allRetailStores.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StoreSumDisplayCell* cell = [tableView dequeueReusableCellWithIdentifier:@"StoreSummary" forIndexPath:indexPath];
    Stores* stores = [allRetailStores objectAtIndex:indexPath.row];
    
    NSURL *url = [NSURL URLWithString:stores.storeLogoURL];
    NSData *imageData  = [NSData dataWithContentsOfURL:url];
    
    cell.storePhoneLabel.text = stores.phone ;
    cell.storeAddressLabel.text =[NSString stringWithFormat:@"%@ %@, %@",stores.address, stores.city, stores.state];
    cell.storeLogoImage.image = [UIImage imageWithData:imageData];
    
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"StoreSumToSpecificDetailsSegue"]) {
        StoreDetailsViewController* sdvc = segue.destinationViewController;
        NSIndexPath* path = [self.tableView indexPathForSelectedRow];
        //sdvc.selectedSpecificStoreDetails = [allRetailStores objectAtIndex:path.row];
        [sdvc fetchFromCoreData:path.row];
                
        //addressLabel, cityLabel, latitudeLabel, zipcodeLabel, phoneLabel,longitudeLabel, stateLabel, mapStoreAddressButtonOutlet, storeLogoDisplayImage;
        
        //NSLog(@"getting passed through %@", );
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
 
 addressLabel.text = [selectedSpecificStoreDetails objectForKey:@"address"];
 cityLabel.text = [selectedSpecificStoreDetails objectForKey:@"city"];
 latitudeLabel.text = @"41.8819"; //[selectedSpecificStoreDetails objectForKey:@"latitude"];
 zipcodeLabel.text = [selectedSpecificStoreDetails objectForKey:@"zipcode"];
 phoneLabel.text = [selectedSpecificStoreDetails objectForKey:@"phone"];
 longitudeLabel.text = @"-87.6278";//[selectedSpecificStoreDetails objectForKey:@"longitude"];
 stateLabel.text = [selectedSpecificStoreDetails objectForKey:@"state"]; 
 
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


@end
