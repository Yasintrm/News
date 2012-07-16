//
//  TwitCell.h
//  News
//
//  Created by Yasin Tarim on 6/23/12.
//
//

#import <UIKit/UIKit.h>
#import "TwitView.h"
#import "Twit.h"

@interface TwitCell : UITableViewCell
@property (nonatomic, strong) Twit *modelData;
@end
