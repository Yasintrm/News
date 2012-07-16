//
//  TableHelper.m
//  News
//
//  Created by Yasin Tarim on 6/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TableHelper.h"
#import "Twit.h"
#import "TwitCell.h"
#import "Helper.h"
@interface TableHelper ()
{
    NSMutableArray *data;
    UITableView *m_tableView;
    Helper* m_helper;
}
@end

@implementation TableHelper

#pragma mark optional UITableView method

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    Twit *twit = [data objectAtIndex:indexPath.row];
    return twit.cellHeight;
}

#pragma mark required UITableView method

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"customcell";
    
    TwitCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[TwitCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    Twit *modelData = [data objectAtIndex:indexPath.row];
    
    if (!modelData.profileImg) {
        
        [m_helper requestImageWithUrl:modelData.profile_image_url CallBack:^(UIImage *image, NSError *error) {
            TwitCell* cell = (TwitCell*)[tableView cellForRowAtIndexPath:indexPath];
            Twit *modelData = [data objectAtIndex:indexPath.row];
            modelData.profileImg = image;
            cell.modelData = modelData;
        }];
    }
    cell.modelData = modelData;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (!m_tableView) {
        m_tableView = tableView;
    }
    return [data count];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if (!m_helper) {
        m_helper = object;
    }
    data = [change objectForKey:NSKeyValueChangeNewKey];
    [m_tableView reloadData];
}

@end
