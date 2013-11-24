//
//  ViewController.h
//  BottleRocket App w. Storyboard & ARC
//
//  Created by John Andrews on 11/23/13.
//  Copyright (c) 2013 John Andrews. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoreDetailsViewController : UIViewController

@property NSDictionary* selectedSpecificStoreDetails;

@property (weak, nonatomic) IBOutlet UIImageView *storeLogoDisplayImage;

@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@property (weak, nonatomic) IBOutlet UILabel *cityLabel;

@property (weak, nonatomic) IBOutlet UILabel *stateLabel;

@property (weak, nonatomic) IBOutlet UILabel *zipcodeLabel;

@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

@property (weak, nonatomic) IBOutlet UILabel *latitudeLabel;

@property (weak, nonatomic) IBOutlet UILabel *longitudeLabel;

@property (weak, nonatomic) IBOutlet UIButton *mapStoreAddressButtonOutlet;

- (IBAction)mapStoreAddressButtonPressed:(id)sender;

- (void)fetchFromCoreData:(NSInteger)selectedRow;

@end
