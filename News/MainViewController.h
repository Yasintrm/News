//
//  MainViewController.h
//  News
//
//  Created by Yasin Tarim on 6/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchBarHelper.h"
#import "TableHelper.h"

@interface MainViewController : UIViewController
@property (strong, nonatomic) IBOutlet SearchBarHelper *searchBarDelegate;
@property (strong, nonatomic) IBOutlet TableHelper *tableViewDelegate;

@end
