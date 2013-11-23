//
//  Stores.h
//  BottleRocket App w. Storyboard & ARC
//
//  Created by John Andrews on 11/23/13.
//  Copyright (c) 2013 John Andrews. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Stores : NSManagedObject

@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * latitude;
@property (nonatomic, retain) NSString * zipcode;
@property (nonatomic, retain) NSString * storeLogoURL;
@property (nonatomic, retain) NSString * phone;
@property (nonatomic, retain) NSString * longitude;
@property (nonatomic, retain) NSString * storeID;
@property (nonatomic, retain) NSString * state;

@end
