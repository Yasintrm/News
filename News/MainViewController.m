//
//  MainViewController.m
//  News
//
//  Created by Yasin Tarim on 6/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MainViewController.h"
#import "Helper.h"

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[Helper sharedInstance] addObserver:_tableViewDelegate forKeyPath:@"data" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)viewDidUnload
{
    [self setSearchBarDelegate:nil];
    [self setTableViewDelegate:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
