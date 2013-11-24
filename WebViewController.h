//
//  WebViewController.h
//  BottleRocket App w. Storyboard & ARC
//
//  Created by John Andrews on 11/23/13.
//  Copyright (c) 2013 John Andrews. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController

- (IBAction)backButtonPressed:(id)sender;

- (IBAction)forwardButtonPressed:(id)sender;

- (IBAction)stopButonPressed:(id)sender;

- (IBAction)refreshButtonPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIWebView *appleWebView;

@end
