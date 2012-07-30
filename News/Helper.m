#import "Helper.h"
#import "Constants.h"

@interface Helper()
@property (nonatomic, strong) NSCache *sharedCache;
-(void) initializeReachability;
@end

@implementation Helper

static Helper* m_helper;

-(void) initializeReachability{
    
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    
    [[AFHTTPClient clientWithBaseURL:[NSURL URLWithString:@"http://www.google.com"]]
     setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
         if (status == AFNetworkReachabilityStatusNotReachable) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 MBProgressHUD*  hud= [MBProgressHUD showHUDAddedTo:window
                                                           animated:YES];
                 hud.mode = MBProgressHUDModeText;
                 hud.dimBackground = YES;
                 hud.labelText = @"No active internet connection";
             });
         }
         else {
             dispatch_async(dispatch_get_main_queue(), ^{
                 [MBProgressHUD hideAllHUDsForView:window animated:NO];
             });
         }
     }];
}

+(void)initialize{
    if (self == [Helper class] && m_helper == nil) {
        m_helper = [[Helper alloc] init];
        m_helper->_sharedCache = [[NSCache alloc] init];
        [m_helper initializeReachability];
    }
}
+(id)sharedInstance{
    return m_helper;
}

-(void)requestImageWithUrl:(NSString *)stringUrl CallBack:(ImageCompletionBlock)callBack{
    UIImage *img = [self.sharedCache objectForKey:stringUrl];
    if (img) {
        callBack(img, nil);
    }
    else {
        NSURL *url = [NSURL URLWithString:[stringUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        NSURLRequest* request = [NSURLRequest requestWithURL:url];
        
        AFImageRequestOperation *imageRequest = [AFImageRequestOperation
                                                 imageRequestOperationWithRequest:request
                                                 imageProcessingBlock:^UIImage *(UIImage *image) {
                                                     return  [self roundCorneredImage:image radius:IMAGE_BORDER];
                                                     
                                                 } success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                                     [self.sharedCache setObject:image forKey:stringUrl];
                                                     callBack(image, nil);
                                                 } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                                     callBack(nil, error);
                                                 }];
        [imageRequest start];
    }
}

-(void)requestJsonWithUrl:(NSString *)stringUrl CallBack:(JSonCompletionBlock)callBack{
    NSURL *url = [NSURL URLWithString:[stringUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFJSONRequestOperation *jsonRequest = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        callBack(JSON, nil);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        callBack(nil, error);
    }];
    
    [jsonRequest start];
}

-(void) bindData:(NSString *)searchKey CallBack:(CallbackBlock)callBack{
    
    NSString *url = [NSString stringWithFormat:SEARCH_URL, [searchKey stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
    
    [self requestJsonWithUrl:url CallBack:^(NSDictionary *json, NSError *error) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSMutableArray *dataArray = [[NSMutableArray alloc] init];
            NSArray *results = json[@"results"];
            float cellWidth = [UIScreen mainScreen].bounds.size.width;
            float textContentWidth = cellWidth - (IMAGE_SIZE + 3 * MARGIN);
            float textStartIndex = IMAGE_SIZE + MARGIN * 2.0f;
            
            for (NSDictionary *item in results) {
                Twit *twit = [[Twit alloc] init];
                twit.id = item[@"id"];
                twit.created_at = item[@"created_at"];
                twit.from_user = item[@"from_user"];
                twit.from_user_name = item[@"from_user_name"];
                twit.profile_image_url = [item[@"profile_image_url"] stringByReplacingOccurrencesOfString:@"normal" withString:@"bigger"];
                twit.text = item[@"text"];
                
                CGSize sizeTitleFrame = [twit.from_user_name sizeWithFont:[UIFont boldSystemFontOfSize:FONT_SIZE_SMALL] constrainedToSize:CGSizeMake(textContentWidth, FONT_SIZE_SMALL) lineBreakMode:UILineBreakModeHeadTruncation];
                
                twit.rectTitleFrame = CGRectMake(textStartIndex, MARGIN, sizeTitleFrame.width, sizeTitleFrame.height + MARGIN);
                
                
                CGSize sizeTextFrame = [twit.text sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE_BIG] constrainedToSize:CGSizeMake(textContentWidth, 20000) lineBreakMode:UILineBreakModeWordWrap];
                twit.rectTextFrame = CGRectMake(textStartIndex, twit.rectTitleFrame.size.height + MARGIN, sizeTextFrame.width, sizeTextFrame.height);
                
                twit.cellHeight = MAX(twit.rectTitleFrame.size.height + twit.rectTextFrame.size.height + 2 * MARGIN, textStartIndex);
                [dataArray addObject:twit];
            }
            
            self.data = dataArray;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callBack();
            });
        });
    }];
}

- (UIImage*) roundCorneredImage: (UIImage*) orig radius:(CGFloat) r {
    
    UIGraphicsBeginImageContextWithOptions(orig.size, NO, [UIScreen mainScreen].scale);
    [[UIBezierPath bezierPathWithRoundedRect:(CGRect){CGPointZero, orig.size}
                                cornerRadius:r] addClip];
    [orig drawInRect:(CGRect){CGPointZero, orig.size}];
    UIImage* result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return result;
}

@end
