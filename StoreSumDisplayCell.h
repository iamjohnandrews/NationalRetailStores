//
//  StoreSumDisplayCell.h
//  BottleRocket App w. Storyboard & ARC
//
//  Created by John Andrews on 11/23/13.
//  Copyright (c) 2013 John Andrews. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoreSumDisplayCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *storeLogoImage;

@property (weak, nonatomic) IBOutlet UILabel *storeAddressLabel;

@property (weak, nonatomic) IBOutlet UILabel *storePhoneLabel;


@end
