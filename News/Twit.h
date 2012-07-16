//
//  Twit.h
//  News
//
//  Created by Yasin Tarim on 6/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Twit : NSObject

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *created_at;
@property (nonatomic, strong) NSString *from_user;
@property (nonatomic, strong) NSString *from_user_name;
@property (nonatomic, strong) NSString *profile_image_url;
@property (nonatomic, strong) NSString *text;
@property (nonatomic) float  cellHeight;
@property (nonatomic) CGRect rectTextFrame;
@property (nonatomic) CGRect rectTitleFrame;
@property (nonatomic, strong) NSString *profileImgUrl;
@property (nonatomic, strong) UIImage *profileImg;

@end
