//
//  TwitView.m
//  News
//
//  Created by Yasin Tarim on 6/23/12.
//
//

#import "TwitView.h"
#import "Constants.h"

@implementation TwitView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [_modelData.from_user_name drawInRect:_modelData.rectTitleFrame withFont:[UIFont boldSystemFontOfSize:FONT_SIZE_SMALL]];
    [_modelData.text drawInRect:_modelData.rectTextFrame withFont:[UIFont systemFontOfSize:FONT_SIZE_BIG]];
    [_modelData.profileImg drawInRect:CGRectMake(MARGIN, MARGIN, IMAGE_SIZE, IMAGE_SIZE)];
    
}

-(void)setModelData:(Twit *)modelData{
    _modelData = modelData;
    self.frame = CGRectMake(0, 0, self.frame.size.width, modelData.cellHeight);
    [self setNeedsDisplay];
}
@end
