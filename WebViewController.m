//
//  WebViewController.m
//  BottleRocket App w. Storyboard & ARC
//
//  Created by John Andrews on 11/23/13.
//  Copyright (c) 2013 John Andrews. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController
@synthesize appleWebView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    NSURL *url = [NSURL URLWithString:@"http://www.apple.com"];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [self.appleWebView loadRequest:urlRequest];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButtonPressed:(id)sender {
    [appleWebView goBack];
}

- (IBAction)forwardButtonPressed:(id)sender {
    [appleWebView goForward];
}

- (IBAction)stopButonPressed:(id)sender {
    [appleWebView stopLoading];
}

- (IBAction)refreshButtonPressed:(id)sender {
    [appleWebView reload];
}
@end
