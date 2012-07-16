#import "SearchBarHelper.h"
#import "Helper.h"
#import "MBProgressHUD.h"

@interface SearchBarHelper ()
{
    UIView* overlayView;
    UISearchBar *m_searchBar;
}
@end

@implementation SearchBarHelper

#pragma mark optional methods

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self hideOverlay];
    
    MBProgressHUD *hud =  [MBProgressHUD showHUDAddedTo:searchBar.superview animated:YES];
    hud.userInteractionEnabled = NO;
    hud.labelText = @"Loading";
    hud.dimBackground = YES;
    [[Helper sharedInstance] bindData:searchBar.text CallBack:^{
        [MBProgressHUD hideHUDForView:searchBar.superview animated:YES];
    }];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    
    if (!m_searchBar) {
        m_searchBar = searchBar;
    }
    
    if (!overlayView) {
        CGRect tableViewRect = [searchBar superview].bounds;
        CGRect searchBarRect = searchBar.bounds;
        CGRect overlayRect = CGRectMake(0, searchBarRect.size.height, searchBarRect.size.width, tableViewRect.size.height);
        overlayView = [[UIView alloc] initWithFrame:overlayRect];
        overlayView.alpha = 0;
        overlayView.backgroundColor = [UIColor blackColor];
        
        [overlayView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideOverlay)]];
        
    }
    [UIView animateWithDuration:0.4 animations:^{
        overlayView.alpha = 0.7;
        [searchBar.superview addSubview:overlayView];
    }];
}
-(void)hideOverlay{
    [m_searchBar resignFirstResponder];
    [overlayView removeFromSuperview];
    overlayView.alpha = 0;
}
@end
