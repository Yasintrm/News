#import <Foundation/Foundation.h>
#import "AFImageRequestOperation.h"
#import "AFJSONRequestOperation.h"
#import "AFNetworking/AFHTTPClient.h"
#import "Twit.h"
#import "MBProgressHUD.h"

typedef void (^ImageCompletionBlock)(UIImage* image, NSError *error);
typedef void (^JSonCompletionBlock)(id json, NSError *error);
typedef void (^CallbackBlock)(void);

@interface Helper : NSObject

@property (nonatomic, strong) NSMutableArray* data;

+(id)sharedInstance;
-(void) requestImageWithUrl:(NSString*)url CallBack:(ImageCompletionBlock)callBack;
-(void) requestJsonWithUrl:(NSString*)url CallBack:(JSonCompletionBlock)callBack;
-(void) bindData:(NSString*)searchKey CallBack:(CallbackBlock) callBack;
-(UIImage*) roundCorneredImage: (UIImage*) orig radius:(CGFloat) r;
@end
