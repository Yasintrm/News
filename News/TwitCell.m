//
//  TwitCell.m
//  News
//
//  Created by Yasin Tarim on 6/23/12.
//
//

#import "TwitCell.h"

@interface TwitCell ()
{
    TwitView *_customView;
}
@end

@implementation TwitCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGSize bounds = self.contentView.bounds.size;
        self.opaque = YES;
        _customView = [[TwitView alloc] initWithFrame:CGRectMake(0, 0, bounds.width, bounds.height)];
        _customView.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:_customView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModelData:(Twit *)modelData{
    _modelData = modelData;
    _customView.modelData = modelData;
}

@end
