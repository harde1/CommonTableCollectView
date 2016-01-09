//
//  CommonTableView.m
//  wukong
//
//  Created by cong on 15/8/4.
//  Copyright (c) 2015年 cong. All rights reserved.
//
#import "CommonTableView.h"
#import <objc/runtime.h>



@interface CommonTableView ()

@property (nonatomic, strong) NSMutableArray*sourceObject;
@property (nonatomic, strong) NSMutableArray*sourcePath;
//给拦截对象的结构体
@property(nonatomic,strong)NSMutableArray * arr_interceptObjectEvent;
@property(nonatomic,assign)int sectionNum;
@property(nonatomic,strong)UITableViewCell * cell_temp;
//事件传值，有状态的,textField和textView传值已经加载里面

@property(nonatomic,copy)DidSelectSectionAtIndexPath didSelectSectionAtIndexPath;
@property(nonatomic,copy)CommitEditingAtIndexPath commitEditingAtIndexPath;
@property(nonatomic,strong)NSMutableArray * arr_heads;
@property(nonatomic,strong)NSMutableArray * arr_headData;

@end

@implementation CommonTableView

- (instancetype)initWithCoder:(NSCoder *)coder{
    self = [super initWithCoder:coder];
    if (self) {
        //省略
        self.delegate = self;
        self.dataSource = self;
        _sectionNum = 1;
        _arr_section = @[@(0.0001)];
        if (!_arrConfig) {
            _arrConfig = [@[[@[] mutableCopy]]mutableCopy];
        }
        
        if (!_arr_dataSource) {
            _arr_dataSource = [@[[@[] mutableCopy]]mutableCopy];
        }
        self.estimatedRowHeight = 44;
        
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    
    if (self = [super initWithFrame:frame style:style]) {
        //省略
        self.delegate = self;
        self.dataSource = self;
        
        _sectionNum = 1;
        _arr_section = @[@(0)];
        if (!_arrConfig) {
            self.arrConfig = [@[[@[] mutableCopy]]mutableCopy];
        }
        if (!_arr_dataSource) {
            _arr_dataSource = [@[[@[] mutableCopy]]mutableCopy];
        }
        self.estimatedRowHeight = 44;
        
    }
    
    return self;
}
- (instancetype)init{
    self = [super init];
    if (self) {
        //省略
        self.delegate = self;
        self.dataSource = self;
        
        _sectionNum = 1;
        _arr_section = @[@(0)];
        if (!_arrConfig) {
            self.arrConfig = [@[[@[] mutableCopy]]mutableCopy];
        }
        if (!_arr_dataSource) {
            _arr_dataSource = [@[[@[] mutableCopy]]mutableCopy];
        }
        
        self.estimatedRowHeight = 44;
        
    }
    return self;
}

- (instancetype)initWithSection:(NSArray *)arr_sections{
    self = [super initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    if (self) {
        //省略
        self.delegate = self;
        self.dataSource = self;
        _arr_section=arr_sections;
        _sectionNum = (int)arr_sections.count;
        if (!_arrConfig) {
            self.arrConfig = [@[]mutableCopy];
            for (int i=0;i<_sectionNum;i++) {
                [self.arrConfig addObject:[@[]mutableCopy]];
            }
            
        }
        if (!_arr_dataSource) {
            _arr_dataSource = [@[]mutableCopy];
            for (int i=0;i<_sectionNum;i++) {
                [_arr_dataSource addObject:[@[]mutableCopy]];
            }
        }
        self.estimatedRowHeight = 44;
        
    }
    return self;
}

-(void)setArr_section:(NSArray *)arr_section{
    
    
    _arr_section=arr_section;
    _sectionNum = (int)arr_section.count;
    
    self.arrConfig = [@[]mutableCopy];
    for (int i=0;i<_sectionNum;i++) {
        [self.arrConfig addObject:[@[]mutableCopy]];
    }
    _arr_dataSource = [@[]mutableCopy];
    for (int i=0;i<_sectionNum;i++) {
        [_arr_dataSource addObject:[@[]mutableCopy]];
    }
    
}




- (instancetype)initWithFrame:(CGRect)frame Section:(NSArray *)arr_sections{
    self = [super initWithFrame:frame style:UITableViewStyleGrouped];
    if (self) {
        //省略
        self.delegate = self;
        self.dataSource = self;
        
        _arr_section=arr_sections;
        _sectionNum = (int)arr_sections.count;
        if (!_arrConfig) {
            self.arrConfig = [@[]mutableCopy];
            for (int i=0;i<_sectionNum;i++) {
                [self.arrConfig addObject:[@[]mutableCopy]];
            }
        }
        if (!_arr_dataSource) {
            _arr_dataSource = [@[]mutableCopy];
            for (int i=0;i<_sectionNum;i++) {
                [_arr_dataSource addObject:[@[]mutableCopy]];
            }
        }
        self.estimatedRowHeight = 44;
        
    }
    return self;
}


-(NSMutableArray *)arr_heads{
    
    if (!_arr_heads) {
        _arr_heads = [@[]mutableCopy];
    }
    return _arr_heads;
}

-(NSMutableArray *)arr_headData{
    
    if (!_arr_headData) {
        _arr_headData = [@[]mutableCopy];
    }
    return _arr_headData;
}





-(void)setViewValueWith:(NSDictionary *)data byView:(UIView *)view tag:(int)tag{
    
    //遍历全部控件
    for (NSString *str_View in [self propertyKeysWith:view]) {
        NSArray * str_ClassMeaning=[self str_ClassMeaning:str_View];
        if (str_ClassMeaning) {
            
            [self setViewValueStr_View:str_View str_Class:str_ClassMeaning[0] andContent:data[str_ClassMeaning[1]] andIndexPath:[NSIndexPath indexPathForRow:tag inSection:tag] inCell:view];
            
        }
        
    }
}

#pragma mark --head
//把字典传进来就开始赋值
-(void)addGroupNibWithData:(NSDictionary *)data andHeadName:(NSString *)headName {
    UIView * v_head = [[NSBundle mainBundle]loadNibNamed:headName owner:self options:nil].firstObject;
    
    [self setViewValueWith:data byView:v_head tag:(int)self.arr_heads.count];
    
    [self.arr_heads addObject:v_head];
    [self.arr_headData addObject:data];
    
    _sectionNum = (int)self.arr_heads.count;
    
    
    if (!self.arrConfig) {
        self.arrConfig = [@[]mutableCopy];
        for (int i=0;i<_sectionNum;i++) {
            [self.arrConfig addObject:[@[]mutableCopy]];
        }
    }else{
        //已经存在的情况下
        for (int i=(int)self.arrConfig.count;i<_sectionNum;i++) {
            [self.arrConfig addObject:[@[]mutableCopy]];
        }
    }
    
    if (!self.arrConfig) {
        self.arrConfig = [@[]mutableCopy];
        for (int i=0;i<_sectionNum;i++) {
            [self.arrConfig addObject:[@[]mutableCopy]];
        }
    }else{
        //已经存在的情况下
        for (int i=(int)self.arrConfig.count;i<_sectionNum;i++) {
            [self.arrConfig addObject:[@[]mutableCopy]];
        }
    }
    
    if (!_closeAutoReload) {
        [self reloadData];
    }
}

-(void)addGroupClassWithData:(NSDictionary *)data andHeadName:(NSString *)headName {
    
    
    UIView * v_head = [[NSClassFromString(headName) alloc]init];
    
    //    [self setViewValueWith:data byView:v_head tag:(int)self.arr_heads.count];
    
    [self.arr_heads addObject:v_head];
    [self.arr_headData addObject:data];
    
    _sectionNum = (int)self.arr_heads.count;
    
    if (!self.arrConfig) {
        self.arrConfig = [@[]mutableCopy];
        for (int i=0;i<_sectionNum;i++) {
            [self.arrConfig addObject:[@[]mutableCopy]];
        }
    }else{
        //已经存在的情况下
        for (int i=(int)self.arrConfig.count;i<_sectionNum;i++) {
            [self.arrConfig addObject:[@[]mutableCopy]];
        }
    }
    
    if (!self.arrConfig) {
        self.arrConfig = [@[]mutableCopy];
        for (int i=0;i<_sectionNum;i++) {
            [self.arrConfig addObject:[@[]mutableCopy]];
        }
    }else{
        //已经存在的情况下
        for (int i=(int)self.arrConfig.count;i<_sectionNum;i++) {
            [self.arrConfig addObject:[@[]mutableCopy]];
        }
    }
    
    if (!_closeAutoReload) {
        [self reloadData];
    }
}

-(void)clearAllData{
    self.arr_dataSource = @[@[].mutableCopy].mutableCopy;
    self.arrConfig = @[@[].mutableCopy].mutableCopy;
    [self reloadData];
}

//一问
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.arrConfig.count;
}
//二问
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.arrConfig[section] count];
}
//三问
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //假如高度是已经计算出来就使用缓存高度
    NSNumber * numHeight = self.arrConfig[indexPath.section][indexPath.row][CELLHEIGHT];
    if (![numHeight isEqualToNumber:@(-1)] && ![numHeight isEqualToNumber:@0]) {
        return [numHeight floatValue];
    }
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:self.arrConfig[indexPath.section][indexPath.row][CELLIDENTIFIER]];
    if (!cell) {
        cell = [(UITableViewCell *) [NSClassFromString(self.arrConfig[indexPath.section][indexPath.row][CELLIDENTIFIER]) alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:self.arrConfig[indexPath.section][indexPath.row][CELLIDENTIFIER]];
    }
    
    if ([cell respondsToSelector:NSSelectorFromString(@"myIndexPath")]) {
        [cell setValue:indexPath forKey:@"myIndexPath"];
    }
    
    if ([cell respondsToSelector:NSSelectorFromString(@"tableView")]) {
        [cell setValue:tableView forKey:@"tableView"];
    }
    if ([cell respondsToSelector:NSSelectorFromString(@"params")]) {
        [cell setValue:self.arrConfig[indexPath.section][indexPath.row][CELLDATASOURCE] forKey:@"params"];
    }
    
    if ([cell isKindOfClass:[CommonCell class]]) {
        CommonCell * commonCell = (CommonCell *)cell;
        [commonCell commonTableView:self inViewController:[self viewController] cellForIndexPath:indexPath];
    }
    
    if (_cellAtIndexPath) {
        _cellAtIndexPath(cell,indexPath);
    }
    
    //[self setAllViewInCell:cell andIndexPath:indexPath];
    
    CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    
    self.arrConfig[indexPath.section][indexPath.row][CELLHEIGHT] = @(height);
    
    
    return height;
}
//一答
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSMutableDictionary * dictData = self.arrConfig[indexPath.section][indexPath.row];
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:self.arrConfig[indexPath.section][indexPath.row][CELLIDENTIFIER]];
    if (!cell) {
        cell = [(UITableViewCell *) [NSClassFromString(dictData[CELLIDENTIFIER]) alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:self.arrConfig[indexPath.section][indexPath.row][CELLIDENTIFIER]];
    }
    
    
    if ([cell respondsToSelector:NSSelectorFromString(@"myIndexPath")]) {
        CommonCell * commonCell = (CommonCell *)cell;
        commonCell.myIndexPath = indexPath;
    }
    
    if ([cell respondsToSelector:NSSelectorFromString(@"tableView")]) {
        CommonCell * commonCell = (CommonCell *)cell;
        commonCell.tableView = self;
    }
    
    if ([cell respondsToSelector:NSSelectorFromString(@"params")]) {
        CommonCell * commonCell = (CommonCell *)cell;
        commonCell.params = dictData[CELLDATASOURCE];
    }
    
    if ([cell isKindOfClass:[CommonCell class]]) {
        CommonCell * commonCell = (CommonCell *)cell;
        [commonCell commonTableView:self inViewController:[self viewController] cellForIndexPath:indexPath];
    }
    
    if (_cellAtIndexPath) {
        _cellAtIndexPath(cell,indexPath);
    }
    //刚刚打开
    if (self.contentOffset.y<20) {
        if ([cell isKindOfClass:[CommonCell class]]) {
            CommonCell * commonCell = (CommonCell *)cell;
            [commonCell commonTableView:self scrollType:scrollViewDidEndDecelerating];
        }else{
            [[NSNotificationCenter defaultCenter] postNotificationName:COMMONTABLEVIEWSCROLL object:@{COMMONTABLEVIE:self,SCROLLTYPE:@(scrollViewDidEndDecelerating)}];
        }
    }
    return cell;
}
//注册cell ,第一步
-(void)setCellClass:(NSString *)str_CellName andCellReuseIdentifier:(NSString *)str_Identifier{
    [self registerClass: NSClassFromString(str_CellName) forCellReuseIdentifier:str_Identifier];
}
-(void)setCellNibName:(NSString *)str_CellName andCellReuseIdentifier:(NSString *)str_Identifier{
    
    [self registerNib:[UINib nibWithNibName:str_CellName bundle:nil] forCellReuseIdentifier:str_Identifier];
}
//-(BOOL)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
//
//    return YES;
//}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (_arr_section.count==0) {
        return 0.001;
    }
    
    if (_commonTableDelegate==nil) {
        
        return [_arr_section[section] floatValue];
    }else{
        CGFloat height = [_commonTableDelegate commonTableView:self heightForHeaderInSection:section];
        return height;
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (_commonTableDelegate) {
        UIView * v_head = [_commonTableDelegate commonTableView:self viewForHeaderInSection:section];
        return v_head;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.001;
}


-(void)removeHeightByIndexPath:(NSIndexPath *)indexPath{
    
    self.arrConfig[indexPath.section][indexPath.row][CELLHEIGHT] = @(-1);
}
-(void)removeHeight{
    
    for (NSMutableArray * arr in self.arrConfig) {
        [arr enumerateObjectsUsingBlock:^(NSMutableDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj[CELLHEIGHT] = @-1;
        }];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0f;
}
//互动
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_didSelectRowAtIndexPath) {
        _didSelectRowAtIndexPath(indexPath);
    }else{
        //        NSLog(@"warning:没有集成DidSelectRowAtIndexPath block");
    }
    
    UITableViewCell * cell = [self cellForRowAtIndexPath:indexPath];
    if ([cell isKindOfClass:[CommonCell class]]) {
        
        
        CommonCell * commonCell = (CommonCell *)cell;
        [commonCell commonTableView:self inViewController:[self viewController] didSelectCellAtIndexPath:indexPath];
        
    }else{
        //        NSLog(@"warning:没有继承CommonCell");
    }
}

- (UIViewController *)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

-(NSArray *)str_ClassMeaning:(NSString *)str_View{
    NSArray * str_ClassMeaning;
    
    
    str_ClassMeaning = [str_View componentsSeparatedByString:@"_"];
    if (str_ClassMeaning.count<2) {
        //        NSLog(@"warining:你的控件名字写错了");
        //        if ([UtilCommon isSimulator]) {
        //            assert(nil);
        //        }
        return nil;
    }
    
    return str_ClassMeaning;
    
}


-(NSString *)str_Meaning:(NSString *)str_View and:(CommonTableView *)weakSelf{
    
    NSArray * str_ClassMeaning = [weakSelf str_ClassMeaning:str_View];
    NSString * str_Class;
    NSString * str_Meaning;
    NSString * str_Meaning2;
    if (str_ClassMeaning) {
        str_Class = str_ClassMeaning[0];
        str_Meaning = str_ClassMeaning[1];//在控件的名字里面提取出来的意义
        
        
        if (str_ClassMeaning.count==3) {
            str_Meaning2 = str_ClassMeaning[2];//在控件的名字里面提取出来的意义
            str_Meaning = [NSString stringWithFormat:@"%@.%@",str_Meaning,str_Meaning2];
        }
        return str_Meaning;
    }
    return nil;
    
}


-(void)setAllViewInCell:(UITableViewCell *)cell andIndexPath:(NSIndexPath *)indexPath
{
    NSArray * arr_Views =   [self propertyKeysWith:cell];
    for (NSString * str_View in arr_Views) {
        
        NSArray * str_ClassMeaning = [self str_ClassMeaning:str_View];
        NSString * str_Class;
        NSString * str_Meaning;
        NSString * str_Meaning2;
        if (str_ClassMeaning) {
            
            
            str_Class = str_ClassMeaning[0];
            str_Meaning = str_ClassMeaning[1];//在控件的名字里面提取出来的意义
            
            if (str_ClassMeaning.count==3) {
                str_Meaning2 = str_ClassMeaning[2];//在控件的名字里面提取出来的意义
                str_Meaning = [NSString stringWithFormat:@"%@.%@",str_Meaning,str_Meaning2];
            }
            
            if ([str_Class isEqualToString:@"arr"]) {
                str_Meaning = str_View;
            }
            
            
            
            //valueForKeyPath
            //            SEL getMethob =NSSelectorFromString(str_Meaning);
            if ([self.arrConfig[indexPath.section][indexPath.row] valueForKeyPath:str_Meaning]) {
                id content = [self.arrConfig[indexPath.section][indexPath.row]  valueForKeyPath:str_Meaning];
                
                
                [self setViewValueStr_View:str_View str_Class:str_Class andContent:content andIndexPath:indexPath inCell:cell];
            }
            else{
                
                //                NSLog(@"waring:数据实体里面不包含--%@ 属性",str_Meaning);
                
            }
            
        }
        
    }
    //cell所有控件反射出来
    //    NSLog(@"cell的所有控件:%@",arr_Views);
}


-(void)setObject:(id)object Value:(NSString *)text InCell:(UITableViewCell *)cell IndexPath:(NSIndexPath *)indexPath{
    NSArray * arr_Views =   [self propertyKeysWith:cell];
    for (NSString * str_View in arr_Views) {
        
        NSArray * str_ClassMeaning;
        NSString * str_Class;
        NSString * str_Meaning;
        NSString * str_Meaning2;
        str_ClassMeaning = [str_View componentsSeparatedByString:@"_"];
        if (str_ClassMeaning.count<2) {
            //            NSLog(@"warining:你的控件名字写错了");
            //            if ([UtilCommon isSimulator]) {
            //                assert(nil);
            //            }
            return;
        }
        str_Class = str_ClassMeaning[0];
        str_Meaning = str_ClassMeaning[1];//在控件的名字里面提取出来的意义
        
        if (str_ClassMeaning.count==3) {
            str_Meaning2 = str_ClassMeaning[2];//在控件的名字里面提取出来的意义
            str_Meaning = [NSString stringWithFormat:@"%@.%@",str_Meaning,str_Meaning2];
        }
        
        
        if ([str_Class isEqualToString:@"arr"]) {
            str_Meaning = str_View;
        }
        
        
        if (object==[cell valueForKey:str_View]) {
            
            //            SEL getMethob =NSSelectorFromString(str_Meaning);
            id value_object = self.arrConfig[indexPath.section][indexPath.row];
            
            if ([value_object valueForKeyPath:str_Meaning]) {
                [value_object setValue:text forKey:str_Meaning];
            }
            else{
                
                //                NSLog(@"waring:数据实体里面不包含--%@ 属性",str_Meaning);
                //                if ([UtilCommon isSimulator]) {
                //                    //                    assert(nil);
                //                }
                
            }
            
            
        }
        
        
        
    }
    
}




/**
 *  设置控件
 *
 *  @param str_View  控件的名字
 *  @param cell      cell
 *  @param indexPath 第几个
 */
-(void)setViewValueStr_View:(id)str_View str_Class:(NSString *)str_Class andContent:(id)content andIndexPath:(NSIndexPath *)indexPath inCell:(UIView *)cell {
    
    //    NSLog(@"str_View:%@,str_Class:%@,content:%@,indexPath:%@,view:%@",str_View,str_Class,content,indexPath,cell);
    //    __weak typeof(self) weakSelf = self;
    
    //驼峰结构不用遵守
    if ([str_Class isEqualToString:@"lb"]||[str_View isKindOfClass:[UILabel class]]) {
        //KVC
        UILabel * lb;
        if ([str_View isKindOfClass:[UILabel class]]) {
            lb=str_View;
        }else
            lb = (UILabel *)[cell valueForKey:str_View];//控件
        if (lb) {
            NSString * text = content;
            lb.text=text;
            lb.numberOfLines = 0;
        }
    }else if ([str_Class isEqualToString:@"tf"]||[str_View isKindOfClass:[UITextField class]]) {
        //KVC
        UITextField * tf;
        if ([str_View isKindOfClass:[UITextField class]]) {
            tf=str_View;
        }else{
            tf = (UITextField *)[cell valueForKey:str_View];//控件
            
        }
        if (tf) {
            tf.delegate = self;
            NSString * text = content;
            
            
            //            if (![self.sourceObject containsObject:tf]) {
            //                [self.sourceObject addObject:tf];
            //                [self.sourcePath addObject:@"text"];
            //            }
            //
            //            [self observeWithObject:tf property:@"text" block:^(id newValue, id oldValue) {
            //
            //
            //
            //
            //
            //
            //                id object = weakSelf.arrConfig[indexPath.section][indexPath.row];
            //
            //                NSString * str_Meaning =  [weakSelf str_Meaning:str_View and:weakSelf];
            //
            //                if (str_Meaning) {
            //                    SEL getMethob =NSSelectorFromString(str_Meaning);
            //                    if ([object respondsToSelector:getMethob]) {
            //                        [object setValue:text forKey:str_Meaning];
            //                    }else{
            //
            //                        NSLog(@"waring:数据实体里面不包含--%@ 属性",str_Meaning);
            //                        if ([UtilCommon isSimulator]) {
            //                            assert(nil);
            //                        }
            //
            //                    }
            //
            //
            //                }
            //
            //
            //            }];
            
            tf.placeholder=text;
        }
    }else if ([str_Class isEqualToString:@"tfv"]||[str_View isKindOfClass:[UITextView class]]) {
        //KVC
        UITextView * tfv;
        if ([str_View isKindOfClass:[UITextView class]]) {
            tfv=str_View;
        }else{
            tfv = (UITextView *)[cell valueForKey:str_View];//控件
        }
        if (tfv) {
            tfv.delegate = self;
            NSString * text = content;
            tfv.text=text;
            //            if (![self.sourceObject containsObject:tfv]) {
            //                [self.sourceObject addObject:tfv];
            //                [self.sourcePath addObject:@"text"];
            //            }
            
            //            [self observeWithObject:tfv property:@"text" block:^(id newValue, id oldValue) {
            //
            //                id object = weakSelf.arrConfig[indexPath.section][indexPath.row];
            //
            //                NSString * str_Meaning =  [weakSelf str_Meaning:str_View and:weakSelf];
            //
            //                if (str_Meaning) {
            //                    SEL getMethob =NSSelectorFromString(str_Meaning);
            //                    if ([object respondsToSelector:getMethob]) {
            //                        [object setValue:text forKey:str_Meaning];
            //                    }else{
            //
            //                        NSLog(@"waring:数据实体里面不包含--%@ 属性",str_Meaning);
            //                        if ([UtilCommon isSimulator]) {
            //                            assert(nil);
            //                        }
            //
            //                    }
            //
            //
            //                }
            //
            //
            //            }];
            
            
            
            
        }
    }else if([str_Class isEqualToString:@"iv"]||[str_View isKindOfClass:[UIImageView class]]){
        
        UIImageView * iv;
        if ([str_View isKindOfClass:[UIImageView class]]) {
            iv=str_View;
        }else
            
            iv = (UIImageView *)[cell valueForKey:str_View];//控件
        if (iv) {
            id object = content;
            
            
            
            if ([object isKindOfClass:[NSString class]]) {
                
                
                if (![self isValid:object]) {
                    
                    //                    [iv mas_updateConstraints:^(MASConstraintMaker *make) {
                    //                        make.height.mas_equalTo(0);
                    //                    }];
                    
                }else{
                    
                    //                    NSString * str_url = object;
                    //                    [iv setImageWithURL:[NSURL URLWithString:str_url]];
                }
            }else if([object isKindOfClass:[UIImage class]]){
                
                [iv setImage:object];
            }else if([object isKindOfClass:[NSURL class]]){
                //                [iv setImageWithURL:object];
            }
            
            else{
                
                //                [iv mas_updateConstraints:^(MASConstraintMaker *make) {
                //                    make.height.mas_equalTo(0);
                //                }];
            }
        }
    }else if([str_Class isEqualToString:@"btn"]||[str_View isKindOfClass:[UIButton class]]){
        
        UIButton * btn;
        if ([str_View isKindOfClass:[UIButton class]]) {
            btn=str_View;
        }else
            btn = (UIButton *)[cell valueForKey:str_View];//控件
        if (btn) {
            btn.tag = indexPath.row;
            id object = content;
            //外观
            if ([object isKindOfClass:[NSString class]]) {
                UIViewController * vc = [self viewController];
                NSString * str_url = object;
                
                
                if ([str_url rangeOfString:@"http://"].location != NSNotFound) {
                    //                    [btn.imageView setImageWithURL:[NSURL URLWithString:str_url]];
                }else if([vc respondsToSelector:NSSelectorFromString(str_url)]){
                    //                    SEL sel_btn = NSSelectorFromString(str_url);
                    //互动
                    //                    [btn addTarget:vc action:sel_btn forControlEvents:UIControlEventTouchUpInside];
                    
                    
                    
                }
            }else if([object isKindOfClass:[UIImage class]]){
                [btn setImage:object forState:UIControlStateNormal];
            }else if([object isKindOfClass:[NSURL class]]){
                //                [btn.imageView setImageWithURL:object];
            }
        }
    }else if([str_Class isEqualToString:@"arr"]||[str_View isKindOfClass:[NSArray class]]){
        
        //如 arr_lb
        NSArray * arr = (NSArray *)[cell valueForKey:str_View];//控件组,直接装了控件的对象
        
        
        
        //里面出现一个数组包含着一个控件,同一种类型的
        if(arr){
            id object = content;
            if ([object isKindOfClass:[NSArray class]]) {
                NSArray * arr_object = (NSArray *)object;//资源组
                
                int i=0;
                for (UIView * str_View in arr) {
                    if (i>=arr_object.count) {
                        //Waring:有些控件没有值
                        [self setViewValueStr_View:str_View str_Class:@"" andContent:nil andIndexPath:indexPath  inCell:cell];
                    }else{
                        
                        [self setViewValueStr_View:str_View str_Class:@"" andContent:arr_object[i] andIndexPath:indexPath  inCell:cell];
                    }
                    
                    i++;
                }
            }
        }
    }
    
}


/**
 *  反射赋值
 *
 *  @param obj        目标对象
 *  @param dataSource 网络数据
 *
 *  @return 成功失败
 */
- (BOOL)reflectDataWith:(id)obj FromOtherObject:(id)dataSource
{
    BOOL ret = NO;
    //获得所有的属性的名字
    for (NSString *key in [self propertyKeysWith:obj]) {
        //网络数据
        if ([dataSource isKindOfClass:[NSDictionary class]]) {
            ret = ([dataSource valueForKey:key]==nil)?NO:YES;
        }else{
            ret = [dataSource respondsToSelector:NSSelectorFromString(key)];
        }
        
        if (ret) {
            id propertyValue = [dataSource valueForKey:key];
            
            //该值不为NSNULL，并且也不为nil
            if (![propertyValue isKindOfClass:[NSNull class]] && propertyValue!=nil) {
                [obj setValue:propertyValue forKey:key];
            }
            
        }
    }
    return ret;
}
- (NSArray*)propertyKeysWith:(id)obj
{
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([obj class], &outCount);
    NSMutableArray *keys = [[NSMutableArray alloc] initWithCapacity:outCount];
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        [keys addObject:propertyName];
    }
    free(properties);
    return keys;
}


-(BOOL)isValid:(NSString *)str{
    if (str) {
        return YES;
    }else{
        if (str.length>0) {
            return YES;
        }
        return NO;
    }
}

-(UITableViewCell *)getViewCellByView:(UIView *)v{
    
    UITableViewCell *cell = (UITableViewCell *)v.superview.superview;
    
    return cell;
}


-(NSIndexPath *)getViewNsIndexPathByView:(UIView *)v{
    UITableViewCell *cell = [self getViewCellByView:v];
    //然后使用indexPathForCell方法，就得到indexPath了~
    NSIndexPath *indexPath = [self indexPathForCell:cell];
    return indexPath;
}



- (void)tapHead:(UITapGestureRecognizer *)sender {
    if (_didSelectSectionAtIndexPath) {
        _didSelectSectionAtIndexPath([NSIndexPath indexPathForRow:0 inSection:sender.view.tag]);
    }
}

//触摸
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
    [self.superview endEditing:YES];
    
    if (_didTouchTableView) {
        _didTouchTableView(self);
    }
    [super touchesBegan:touches withEvent:event];
}

-(void)addNibWithEntity:(id)object andCellName:(NSString *)cellName {
    [self addNibWithEntity:object andCellName:cellName andSection:0];
}
-(void)addClassWithEntity:(id)object andCellName:(NSString *)cellName {
    [self addClassWithEntity:object andCellName:cellName andSection:0];
}

#pragma mark -- 插入\删除一个cell --
-(void)insertIndexPath:(NSIndexPath *)indexPath withNibWithEntity:(id)object andCellName:(NSString *)cellName withRowAnimation:(UITableViewRowAnimation)animation{
    if (indexPath.row==0 && [self.arrConfig[indexPath.section] count]==0) {
        [self addNibWithEntity:object andCellName:cellName];
        return;
    }
    [self setCellNibName:cellName andCellReuseIdentifier:cellName];
    
    [self insertCellAllowEdit:NO editStyle:UITableViewCellEditingStyleNone indexPath:indexPath withEntity:object andCellName:cellName withRowAnimation:animation];
}
-(void)insertIndexPath:(NSIndexPath *)indexPath withClassWithEntity:(id)object andCellName:(NSString *)cellName withRowAnimation:(UITableViewRowAnimation)animation{
    
    if (indexPath.row==0 && [self.arrConfig[indexPath.section] count]==0) {
        [self addClassWithEntity:object andCellName:cellName];
        return;
    }
    [self setCellClass:cellName andCellReuseIdentifier:cellName];
    [self insertCellAllowEdit:NO editStyle:UITableViewCellEditingStyleNone indexPath:indexPath withEntity:object andCellName:cellName withRowAnimation:animation];
}

-(void)insertInEditStyle:(UITableViewCellEditingStyle)editStyle indexPath:(NSIndexPath *)indexPath withNibWithEntity:(id)object andCellName:(NSString *)cellName withRowAnimation:(UITableViewRowAnimation)animation{
    
    if (indexPath.row==0 && [self.arrConfig[indexPath.section] count]==0) {
        [self addNibWithEntity:object andCellName:cellName];
        return;
    }
    [self setCellNibName:cellName andCellReuseIdentifier:cellName];
    
    [self insertCellAllowEdit:YES editStyle:editStyle indexPath:indexPath withEntity:object andCellName:cellName withRowAnimation:animation];
    
}
-(void)insertInEditStyle:(UITableViewCellEditingStyle)editStyle indexPath:(NSIndexPath *)indexPath withClassWithEntity:(id)object andCellName:(NSString *)cellName withRowAnimation:(UITableViewRowAnimation)animation{
    
    if (indexPath.row==0 && [self.arrConfig[indexPath.section] count]==0) {
        [self addClassWithEntity:object andCellName:cellName];
        return;
    }
    [self setCellClass:cellName andCellReuseIdentifier:cellName];
    [self insertCellAllowEdit:YES editStyle:editStyle indexPath:indexPath withEntity:object andCellName:cellName withRowAnimation:animation];
}
//插入数据
-(void)insertCellAllowEdit:(BOOL)allowEdit editStyle:(UITableViewCellEditingStyle)editStyle indexPath:(NSIndexPath *)indexPath withEntity:(id)object andCellName:(NSString *)cellName withRowAnimation:(UITableViewRowAnimation)animation{
    
    [self.arrConfig[indexPath.section] insertObject:@{CELLIDENTIFIER:cellName,CELLDATASOURCE:object,CELLHEIGHT:@-1,CELLCANEDIT:@(allowEdit),CELLEDITINGSTYLE:@(editStyle)}.mutableCopy atIndex:indexPath.row];
    
    [self.arr_dataSource[indexPath.section] insertObject:object atIndex:indexPath.row];
    [self beginUpdates];
    [self insertRowsAtIndexPaths:@[indexPath] withRowAnimation:animation];
    [self endUpdates];
}





-(void)removeIndexPath:(NSIndexPath *)indexPath andCellName:(NSString *)cellName withRowAnimation:(UITableViewRowAnimation)animation{
    
    @try {
        
        if ([self.arrConfig[indexPath.section][indexPath.row][CELLIDENTIFIER] isEqualToString:cellName]) {
            
            
            [self.arrConfig[indexPath.section] removeObjectAtIndex:indexPath.row];
            [self.arr_dataSource[indexPath.section] removeObjectAtIndex:indexPath.row];
            [self beginUpdates];
            [self deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:animation];
            [self endUpdates];
        }
        
    }
    @catch (NSException *exception) {
        NSLog(@"@warning: %@",exception);
    }
    @finally {
        
    }
    
}

-(void)removeIndexPath:(NSIndexPath *)indexPath withRowAnimation:(UITableViewRowAnimation)animation{
    
    @try {
        
        
        [self.arrConfig[indexPath.section] removeObjectAtIndex:indexPath.row];
        [self.arr_dataSource[indexPath.section] removeObjectAtIndex:indexPath.row];
        [self beginUpdates];
        [self deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:animation];
        [self endUpdates];
    }
    @catch (NSException *exception) {
        NSLog(@"@warning: %@",exception);
    }
    @finally {
        
    }
    
}



-(void)addNibWithEntity:(id)object andCellName:(NSString *)cellName andSection:(int)section {
    
    //1、判断是否要注册，数组判断
    if (![cellName isEqualToString:@"UITableViewCell"]) {
        [self setCellNibName:cellName andCellReuseIdentifier:cellName];
    }
    
    [self addCellWithEntity:object andCellName:cellName allowEdit:NO editStyle:UITableViewCellEditingStyleNone andSection:section];
}

-(void)addClassWithEntity:(id)object andCellName:(NSString *)cellName andSection:(int)section {
    
    //增加这个东西的时候
    //通过section,知道维数
    //row 里面存一个字典，字典里面放三个值，分别是cell的名字，cell的数据，cell的高度
    //CELLIDENTIFIER   CELLDATASOURCE   CELLHEIGHT
    
    //1、判断是否要注册，数组判断
    if (![cellName isEqualToString:@"UITableViewCell"]) {
        [self setCellClass:cellName andCellReuseIdentifier:cellName];
    }
    [self addCellWithEntity:object andCellName:cellName allowEdit:NO editStyle:UITableViewCellEditingStyleNone andSection:section];
}


-(void)addCellWithEntity:(id)object andCellName:(NSString *)cellName allowEdit:(BOOL)allowEdit editStyle:(UITableViewCellEditingStyle)editStyle andSection:(int)section {
    
    //2、 调整结构
    while (self.arrConfig.count<=section) {
        [self.arrConfig addObject:@[].mutableCopy];
    }
    while (self.arr_dataSource.count<=section) {
        [self.arr_dataSource addObject:@[].mutableCopy];
    }
    //3、添加数据进去
    [self.arrConfig[section] addObject:@{CELLIDENTIFIER:cellName,CELLDATASOURCE:object,CELLHEIGHT:@-1,CELLCANEDIT:@(allowEdit),CELLEDITINGSTYLE:@(editStyle)}.mutableCopy];
    
    [self.arr_dataSource[section] addObject:object];
    
    if (!_closeAutoReload) {
        [self reloadData];
    }
}
#pragma mark -- 编辑模式 --
-(void)addNibWithEntity:(id)obj andCellName:(NSString *)cellName editStyle:(UITableViewCellEditingStyle)editStyle{
    [self addNibWithEntity:obj andCellName:cellName editStyle:editStyle andSection:0];
}
-(void)addClassWithEntity:(id)obj andCellName:(NSString *)cellName editStyle:(UITableViewCellEditingStyle)editStyle{
    [self addClassWithEntity:obj andCellName:cellName editStyle:editStyle andSection:0];
}
-(void)addNibWithEntity:(id)obj andCellName:(NSString *)cellName editStyle:(UITableViewCellEditingStyle)editStyle andSection:(int)section{
    if (![cellName isEqualToString:@"UITableViewCell"]) {
        [self setCellNibName:cellName andCellReuseIdentifier:cellName];
    }
    [self addCellWithEntity:obj andCellName:cellName allowEdit:YES editStyle:editStyle andSection:section];
}
-(void)addClassWithEntity:(id)obj andCellName:(NSString *)cellName editStyle:(UITableViewCellEditingStyle)editStyle andSection:(int)section{
    if (![cellName isEqualToString:@"UITableViewCell"]) {
        [self setCellClass:cellName andCellReuseIdentifier:cellName];
    }
    [self addCellWithEntity:obj andCellName:cellName allowEdit:YES editStyle:editStyle andSection:section];
}
#pragma mark -- 编辑模式 end --





-(void)commonTableViewCellAtIndexPath:(CellAtIndexPath)cellAtIndexPath andDidSelectRowAtIndexPath:(DidSelectRowAtIndexPath)didSelectRowAtIndexPath {
    _cellAtIndexPath = cellAtIndexPath;
    
    _didSelectRowAtIndexPath = didSelectRowAtIndexPath;
}


-(void)setDidSelectRowAtIndexPath:(DidSelectRowAtIndexPath)didSelectRowAtIndexPath{
    
    _didSelectRowAtIndexPath = didSelectRowAtIndexPath;
}

-(void)setCellAtIndexPath:(CellAtIndexPath)cellAtIndexPath{
    _cellAtIndexPath = cellAtIndexPath;
}

-(void)setCommitEditingAtIndexPath:(CommitEditingAtIndexPath)commitEditingAtIndexPath{
    _commitEditingAtIndexPath = commitEditingAtIndexPath;
}

-(NSMutableArray *)arr_interceptObjectEvent{
    
    if (!_arr_interceptObjectEvent) {
        _arr_interceptObjectEvent =[@[]mutableCopy];
    }
    return _arr_interceptObjectEvent;
}
-(void)interceptObjectEvent:(UIView *)view{
    
    
    if (![self.arr_interceptObjectEvent containsObject:view]) {
        [self.arr_interceptObjectEvent addObject:view];
    }
    
}

-(void)setDidTouchTableView:(DidTouchTableView)didTouchTableView{
    
    _didTouchTableView = didTouchTableView;
}


#pragma mark --- 编辑模式 ---
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.arrConfig[indexPath.section][indexPath.row][CELLCANEDIT] boolValue];
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [self.arrConfig[indexPath.section][indexPath.row][CELLEDITINGSTYLE] integerValue];
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (_commitEditingAtIndexPath) {
        _commitEditingAtIndexPath(cell,editingStyle,indexPath);
    }
    if ([cell isKindOfClass:[CommonCell class]]) {
        CommonCell * commonCell = (CommonCell *)cell;
        [commonCell commonTableView:self commitEditingStyle:editingStyle forRowAtIndexPath:indexPath];
    }
    
}

#pragma mark -- UIScrollViewDelegate --
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [[NSNotificationCenter defaultCenter] postNotificationName:COMMONTABLEVIEWSCROLL object:@{COMMONTABLEVIE:self,SCROLLTYPE:@(scrollViewDidScroll)}];
}
- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    [[NSNotificationCenter defaultCenter] postNotificationName:COMMONTABLEVIEWSCROLL object:@{COMMONTABLEVIE:self,SCROLLTYPE:@(scrollViewDidZoom)}];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [[NSNotificationCenter defaultCenter] postNotificationName:COMMONTABLEVIEWSCROLL object:@{COMMONTABLEVIE:self,SCROLLTYPE:@(scrollViewWillBeginDragging)}];
}
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset NS_AVAILABLE_IOS(5_0){
    [[NSNotificationCenter defaultCenter] postNotificationName:COMMONTABLEVIEWSCROLL object:@{COMMONTABLEVIE:self,SCROLLTYPE:@(scrollViewWillEndDragging)}];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [[NSNotificationCenter defaultCenter] postNotificationName:COMMONTABLEVIEWSCROLL object:@{COMMONTABLEVIE:self,SCROLLTYPE:@(scrollViewDidEndDragging)}];
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    [[NSNotificationCenter defaultCenter] postNotificationName:COMMONTABLEVIEWSCROLL object:@{COMMONTABLEVIE:self,SCROLLTYPE:@(scrollViewWillBeginDecelerating)}];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [[NSNotificationCenter defaultCenter] postNotificationName:COMMONTABLEVIEWSCROLL object:@{COMMONTABLEVIE:self,SCROLLTYPE:@(scrollViewDidEndDecelerating)}];
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:COMMONTABLEVIEWSCROLL object:@{COMMONTABLEVIE:self,SCROLLTYPE:@(scrollViewDidEndScrollingAnimation)}];
}
- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view{
    [[NSNotificationCenter defaultCenter] postNotificationName:COMMONTABLEVIEWSCROLL object:@{COMMONTABLEVIE:self,SCROLLTYPE:@(scrollViewWillBeginZooming)}];
}
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view atScale:(CGFloat)scale{
    [[NSNotificationCenter defaultCenter] postNotificationName:COMMONTABLEVIEWSCROLL object:@{COMMONTABLEVIE:self,SCROLLTYPE:@(scrollViewDidEndZooming)}];
}
- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView{
    [[NSNotificationCenter defaultCenter] postNotificationName:COMMONTABLEVIEWSCROLL object:@{COMMONTABLEVIE:self,SCROLLTYPE:@(scrollViewShouldScrollToTop)}];
    return YES;
}
- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView{
    [[NSNotificationCenter defaultCenter] postNotificationName:COMMONTABLEVIEWSCROLL object:@{COMMONTABLEVIE:self,SCROLLTYPE:@(scrollViewDidScrollToTop)}];
}


@end
