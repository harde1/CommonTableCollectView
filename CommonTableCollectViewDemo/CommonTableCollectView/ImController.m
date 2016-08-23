//
//  ImController.m
//  CommonTableCollectView
//
//  Created by wukong on 16/1/19.
//  Copyright © 2016年 cong. All rights reserved.
//

#import "ImController.h"
#import "CommonTableView.h"

#import "CellImRight.h"
#import "Masonry.h"
#import "Msg.h"
@interface ImController ()<UITextFieldDelegate>
@property(nonatomic,strong)CommonTableView * tvIm;
@property(nonatomic,strong)UITextField * tfInput;
@property(nonatomic,strong)UIView * vInput;
@property(nonatomic,strong)UIButton * btnInput;
@end

@implementation ImController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"客服";
    [self initUI];
}

- (void)initUI {
    
    //tv
    _tvIm = [[CommonTableView alloc]init];
    _tvIm.scrolltoBottom = YES;
    _tvIm.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tvIm.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    [self.view addSubview:_tvIm];
    [_tvIm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
    }];
    
    //vInput
    _vInput = [UIView new];
    _vInput.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_vInput];
    
    [_vInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.view);
        make.top.equalTo(_tvIm.mas_bottom);
        make.height.mas_equalTo(@60);
    }];
    
    //tfInput
    _tfInput = [[UITextField alloc]init];
    _tfInput.delegate = self;
    _tfInput.backgroundColor = [UIColor whiteColor];
    _tfInput.textColor = [UIColor blackColor];
    [_vInput addSubview:_tfInput];
    [_tfInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.top.equalTo(_vInput).with.insets(UIEdgeInsetsMake(15, 10, 15, 0));
        
    }];
    
    //btnInput
    _btnInput = [UIButton buttonWithType:UIButtonTypeSystem];
    _btnInput.backgroundColor = [UIColor redColor];
    [_btnInput setTitle:@"发送" forState:UIControlStateNormal];
    [_btnInput setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
    _btnInput.layer.cornerRadius = 3;
    _btnInput.layer.masksToBounds = YES;
    _btnInput.layer.shouldRasterize = YES;
    _btnInput.layer.rasterizationScale = [UIScreen mainScreen].scale;
    [_vInput addSubview:_btnInput];
    [_btnInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.top.equalTo(_vInput).with.insets(UIEdgeInsetsMake(15, 0, 15, 10));
        make.left.equalTo(_tfInput.mas_right).with.offset(10);
        make.width.mas_equalTo(60);
    }];
    
    [_btnInput addTarget:self action:@selector(clickInput:) forControlEvents:UIControlEventTouchUpInside];
    
    //line
    UIView * line = [UIView new];
    [_vInput addSubview:line];
    line.backgroundColor = [UIColor whiteColor];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(line.superview);
        make.height.mas_equalTo(1);
    }];
    
}
- (int)getRandomNumber:(int)from to:(int)to
{
    return (int)(from + (arc4random() % (to - from + 1)));
}

- (void)clickInput:(UIButton *)sender {
    
    int ii = [self getRandomNumber:0 to:1];
    
    int suijiNum = [self getRandomNumber:0 to:1];
    
    
    __block Msg * msg = [Msg new];
    msg.textBody = _tfInput.text;
    msg.createTime =@"时间啊啊啊啊";
    [self.tvIm addNibWithEntity:msg
                    andCellName:ii==0?@"CellImRight":@"CellImLeft"];
    
    self.tfInput.text = @"";
    
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC));
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        
        if (suijiNum==1) {
            msg.state = 1;
        }else{
            msg.state = -1;
        }
        
        [self.tvIm reloadData];
        
    });
    
    
    
    [self scrollToBottom];
    
    
    
    
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self scrollToBottom];
}

-(void)scrollToBottom{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (_tvIm.contentSize.height<CGRectGetHeight(_tvIm.frame)) {
            return;
        }
        NSIndexPath * last = [NSIndexPath indexPathForRow:[_tvIm.arr_dataSource[0] count]-1 inSection:0];
        [_tvIm scrollToRowAtIndexPath:last atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    });
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self clickInput:_btnInput];
    return YES;
}


@end
