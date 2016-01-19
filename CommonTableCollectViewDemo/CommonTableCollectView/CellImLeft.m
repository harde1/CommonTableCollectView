//
//  CellImLeft.m
//  BiggerPai
//
//  Created by wukong on 16/1/15.
//  Copyright © 2016年 lhc. All rights reserved.
//

#import "CellImLeft.h"
#import "Masonry.h"
#import "Msg.h"
#import "CommonTableView.h"
@implementation CellImLeft

- (void)awakeFromNib {
    
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    _ivError.hidden = YES;
    _vLoading.hidden = YES;
    _ivError.image = [UIImage imageNamed:@"gantan"];
    
    
    
    
    UIView * vlongP = [UIView new];
    [self.contentView addSubview:vlongP];
    
    [vlongP mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    
    UILongPressGestureRecognizer * longPressGr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressToDo:)];
    longPressGr.minimumPressDuration = 1.0;
    [vlongP addGestureRecognizer:longPressGr];
}
-(void)commonTableView:(CommonTableView *)tableView inViewController:(UIViewController *)viewController cellForIndexPath:(NSIndexPath *)indexPath{
    Msg * msg = self.params;
    _lbContent.text = msg.textBody;
    _lbTime.text = msg.createTime;
    _ivError.hidden = msg.state==-1?NO:YES;//==-1,显示错误
    _vLoading.hidden = msg.state==0?NO:YES;
    
    
    [_vLoading startAnimating];
}


-(void)commonTableView:(CommonTableView *)tableView inViewController:(UIViewController *)viewController didSelectCellAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

-(void)longPressToDo:(UILongPressGestureRecognizer *)gesture{
    
    if (gesture.state == UIGestureRecognizerStateBegan) {
        
        CellImLeft *cell = self;
        [cell becomeFirstResponder];
        
        UIMenuItem *copy = [[UIMenuItem alloc] initWithTitle:@"copy" action:@selector(mycopy:)];
        UIMenuItem *share = [[UIMenuItem alloc] initWithTitle:@"share" action:@selector(share:)];
        UIMenuItem *userInfo = [[UIMenuItem alloc] initWithTitle:@"userInfo" action:@selector(userInfo:)];
        
        UIMenuController *menu = [UIMenuController sharedMenuController];
        //menu.arrowDirection = UIMenuControllerArrowUp;
        [menu setMenuItems:[NSArray arrayWithObjects:copy, share, userInfo, nil]];
        
        CGRect frame = cell.frame;
        frame.origin.y = cell.frame.origin.y+_lbContent.frame.origin.y;
        frame.size.width = CGRectGetMaxX(_lbContent.frame);
        [menu setTargetRect:frame inView:cell.superview];
        [menu setMenuVisible:YES animated:YES];
        
        
        
    }
    
}
- (BOOL)canBecomeFirstResponder{
    
    return YES;
}
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    
    if (action ==@selector(mycopy:)||
        action ==@selector(share:)||
        action ==@selector(userInfo:)){
        return YES;
    }
    return NO;//隐藏系统默认的菜单项
}
- (void)mycopy:(id)sender {
    NSLog(@"Cell was copy");
    [UIPasteboard generalPasteboard].string = self.params[@"content"];
    
}

- (void)userInfo:(id)sender {
    NSLog(@"Cell was userInfo");
}

- (void)share:(id)sender {
    NSLog(@"Cell was share");
}

@end
