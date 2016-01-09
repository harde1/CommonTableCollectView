//
//  PicController.m
//  CommonTableCollectView
//
//  Created by wukong on 15/12/15.
//  Copyright © 2015年 cong. All rights reserved.
//

#import "PicController.h"

@interface PicController ()

@end

@implementation PicController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    NSArray * arrPic = @[@"http://imgsrc.baidu.com/forum/w%3D580/sign=d330e4800c23dd542173a760e108b3df/475704540923dd544e6d3f8cd409b3de9d8248f8.jpg",@"http://imgsrc.baidu.com/forum/w%3D580/sign=01422f1f3cdbb6fd255be52e3925aba6/dd9ecccb39dbb6fd02fe7ec20c24ab18962b3775.jpg",@"http://imgsrc.baidu.com/forum/w%3D580/sign=4cead30d881001e94e3c1407880f7b06/2f8831d98d1001e9d6278eebbd0e7bec55e79784.jpg",@"http://imgsrc.baidu.com/forum/w%3D580/sign=16533047f303738dde4a0c2a831ab073/35450790f603738d062543c5b61bb051f919ecab.jpg",@"http://imgsrc.baidu.com/forum/w%3D580/sign=714d7600942397ddd679980c6983b216/e97c41d7912397ddb531d7e35c82b2b7d1a28755.jpg",@"http://imgsrc.baidu.com/forum/w%3D580/sign=9253e5874ac2d562f208d0e5d71090f3/357cd6504fc2d562ae5e9b0ae21190ef77c66c43.jpg",@"http://imgsrc.baidu.com/forum/w%3D580/sign=c78756ef1a30e924cfa49c397c096e66/8b4c65381f30e9247816d7d649086e061c95f768.jpg",@"http://imgsrc.baidu.com/forum/w%3D580/sign=59e58525b7119313c743ffb855390c10/df07b6f2b2119313bad8b45760380cd790238d06.jpg",@"http://imgsrc.baidu.com/forum/w%3D580/sign=19a6b37aceef76093c0b99971edca301/80b07cadcbef76095e642e782bdda3cc7dd99eaa.jpg"];
    
    
    
    
    
    for (NSString * strUrl in arrPic) {
        [_tvPic addNibWithEntity:@{@"pic":strUrl} andCellName:@"Cell_Essence_1"];
    }
    for (NSString * strUrl in arrPic) {
        [_tvPic addNibWithEntity:@{@"pic":strUrl} andCellName:@"Cell_Essence_1"];
    }
    for (NSString * strUrl in arrPic) {
        [_tvPic addNibWithEntity:@{@"pic":strUrl} andCellName:@"Cell_Essence_1"];
    }
}

@end
