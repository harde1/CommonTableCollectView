//
//  CommonCell.m
//  PudiEdu
//
//  Created by cong on 15/10/4.
//  Copyright © 2015年 cong. All rights reserved.
//

#import "CommonCell.h"



@implementation CommonCell

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:COMMONTABLEVIEWSCROLL object:nil];
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(commonTableScrolling:) name:COMMONTABLEVIEWSCROLL object:nil];
    }
    return self;
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super initWithCoder:aDecoder]) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(commonTableScrolling:) name:COMMONTABLEVIEWSCROLL object:nil];
    }
    return self;
}
-(void)commonTableView:(CommonTableView *)tableView inViewController:(UIViewController *)viewController didSelectCellAtIndexPath:(NSIndexPath *)indexPath{
    
}
-(void)commonTableView:(CommonTableView *)tableView inViewController:(UIViewController *)viewController cellForIndexPath:(NSIndexPath *)indexPath {
    
}
- (void)commonTableView:(CommonTableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}
- (void)commonTableScrolling:(NSNotification *)notif {
    ScrollType scrollType = [notif.object[SCROLLTYPE] integerValue];
    UITableView * tv = (UITableView *)self.tableView;
    if (![tv isEqual:notif.object[COMMONTABLEVIE]] && (scrollType==scrollViewWillBeginDecelerating || scrollType == scrollViewDidEndDecelerating || scrollType == scrollViewDidEndDragging) && self.isShow) {
        return;
    }
    
    [self commonTableView:notif.object[COMMONTABLEVIE] scrollType:scrollType];
}
-(void)commonTableView:(CommonTableView *)tableView scrollType:(ScrollType)scrollType{
    
}

-(BOOL)isShow{
    _isShow = NO;
    UITableView * tv = (UITableView *)self.tableView;
    if (tv) {
        if (CGRectGetMaxY(self.frame)<tv.contentOffset.y || CGRectGetMinY(self.frame)>tv.contentOffset.y+CGRectGetHeight(tv.frame)) {
            _isShow = NO;
        }else{
            _isShow = YES;
        }
    }
    return _isShow;
}

@end
