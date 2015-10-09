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

@property(nonatomic,strong)NSMutableArray * arr_interceptObjectEvent;//给拦截对象的结构体


@property(nonatomic,assign)int sectionNum;
@property(nonatomic,strong)UITableViewCell * cell_temp;

@property(nonatomic,copy)CellAtIndexPathSendData cellAtIndexPathSendData; //事件传值，有状态的,textField和textView传值已经加载里面
@property(nonatomic,copy)DidSelectSectionAtIndexPath didSelectSectionAtIndexPath;


@property(nonatomic,strong)NSMutableArray * arr_heads;
@property(nonatomic,strong)NSMutableArray * arr_headData;

@end


@implementation CommonTableView


- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        //省略
        self.delegate = self;
        self.dataSource = self;
        _sectionNum = 1;
        _arr_section = @[@(0.0001)];
        if (!_arr_dataSource) {
            self.arr_dataSource = [@[[@[] mutableCopy]]mutableCopy];
        }
        if (!_arr_Config) {
            self.arr_Config = [@[[@[] mutableCopy]]mutableCopy];
        }
        
        
        
        self.estimatedRowHeight = 200;
        self.rowHeight = UITableViewAutomaticDimension;
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
        if (!_arr_dataSource) {
            self.arr_dataSource = [@[[@[] mutableCopy]]mutableCopy];
        }
        if (!_arr_Config) {
            self.arr_Config = [@[[@[] mutableCopy]]mutableCopy];
        }
        
        self.estimatedRowHeight = 200;
        self.rowHeight = UITableViewAutomaticDimension;
    }
    
    return self;
}

-(NSMutableDictionary *)dict_heightSave{
    
    if (!_dict_heightSave) {
        _dict_heightSave = [@{}mutableCopy];
    }
    
    return _dict_heightSave;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        //省略
        self.delegate = self;
        self.dataSource = self;
        
        _sectionNum = 1;
        _arr_section = @[@(0)];
        if (!_arr_dataSource) {
            self.arr_dataSource = [@[[@[] mutableCopy]]mutableCopy];
        }
        if (!_arr_Config) {
            self.arr_Config = [@[[@[] mutableCopy]]mutableCopy];
        }
        
        self.estimatedRowHeight = 200;
        self.rowHeight = UITableViewAutomaticDimension;
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
        if (!_arr_dataSource) {
            self.arr_dataSource = [@[]mutableCopy];
            for (int i=0;i<_sectionNum;i++) {
                [self.arr_dataSource addObject:[@[]mutableCopy]];
            }
            
        }
        if (!_arr_Config) {
            self.arr_Config = [@[]mutableCopy];
            
            for (int i=0;i<_sectionNum;i++) {
                [self.arr_Config addObject:[@[]mutableCopy]];
            }
        }
        
        
        self.estimatedRowHeight = 200;
        self.rowHeight = UITableViewAutomaticDimension;
    }
    return self;
}

-(void)setArr_section:(NSArray *)arr_section{
    
    
    _arr_section=arr_section;
    _sectionNum = (int)arr_section.count;
    
    self.arr_dataSource = [@[]mutableCopy];
    for (int i=0;i<_sectionNum;i++) {
        [self.arr_dataSource addObject:[@[]mutableCopy]];
    }
    
    
    
    self.arr_Config = [@[]mutableCopy];
    
    for (int i=0;i<_sectionNum;i++) {
        [self.arr_Config addObject:[@[]mutableCopy]];
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
        if (!_arr_dataSource) {
            self.arr_dataSource = [@[]mutableCopy];
            for (int i=0;i<_sectionNum;i++) {
                [self.arr_dataSource addObject:[@[]mutableCopy]];
            }
            
        }
        if (!_arr_Config) {
            self.arr_Config = [@[]mutableCopy];
            
            for (int i=0;i<_sectionNum;i++) {
                [self.arr_Config addObject:[@[]mutableCopy]];
            }
        }
        
        
        self.estimatedRowHeight = 200;
        self.rowHeight = UITableViewAutomaticDimension;
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
    
    
    if (!self.arr_dataSource) {
        self.arr_dataSource = [@[]mutableCopy];
        for (int i=0;i<_sectionNum;i++) {
            [self.arr_dataSource addObject:[@[]mutableCopy]];
        }
    }else{
        //已经存在的情况下
        for (int i=(int)self.arr_dataSource.count;i<_sectionNum;i++) {
            [self.arr_dataSource addObject:[@[]mutableCopy]];
        }
    }
    
    
    if (!self.arr_Config) {
        
        
        self.arr_Config = [@[]mutableCopy];
        for (int i=0;i<_sectionNum;i++) {
            [self.arr_Config addObject:[@[]mutableCopy]];
        }
        
    }else{
        
        for (int i=(int)self.arr_Config.count;i<_sectionNum;i++) {
            [self.arr_Config addObject:[@[]mutableCopy]];
        }
        
    }
    
    
    if (!_closeAutoReload) {
        [self reloadData];
    }
}

-(void)addGroupClassWithData:(NSDictionary *)data andHeadName:(NSString *)headName {
    
    
    UIView * v_head = [[NSClassFromString(headName) alloc]init];
    
    [self setViewValueWith:data byView:v_head tag:(int)self.arr_heads.count];
    
    [self.arr_heads addObject:v_head];
    [self.arr_headData addObject:data];
    
    _sectionNum = (int)self.arr_heads.count;
    
    if (!self.arr_dataSource) {
        
        
        self.arr_dataSource = [@[]mutableCopy];
        for (int i=0;i<_sectionNum;i++) {
            [self.arr_dataSource addObject:[@[]mutableCopy]];
        }
    }else{
        //已经存在的情况下
        
        
        for (int i=(int)self.arr_dataSource.count;i<_sectionNum;i++) {
            [self.arr_dataSource addObject:[@[]mutableCopy]];
        }
    }
    
    
    if (!self.arr_Config) {
        self.arr_Config = [@[]mutableCopy];
        for (int i=0;i<_sectionNum;i++) {
            [self.arr_Config addObject:[@[]mutableCopy]];
        }
        
    }else{
        
        for (int i=(int)self.arr_Config.count;i<_sectionNum;i++) {
            [self.arr_Config addObject:[@[]mutableCopy]];
        }
        
    }
    
    if (!_closeAutoReload) {
        [self reloadData];
    }
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _sectionNum;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSInteger num =[self.arr_dataSource[section] count];
    
    
    return num;
}

-(void)clearAllData{
    
    
    if (self.arr_Config) {
        for (int i=0;i<self.arr_Config.count;i++) {
            self.arr_Config[i] = [@[]mutableCopy];
        }
    }
    if (self.arr_dataSource) {
        for (int i=0;i<self.arr_dataSource.count;i++) {
            self.arr_dataSource[i] = [@[]mutableCopy];
        }
        _sectionNum = (int)(self.arr_dataSource.count==0?1:self.arr_dataSource.count);
    }
    
    
    
    [self.dict_heightSave removeAllObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.arr_Config.count<=indexPath.section) {
        NSLog(@"waring:section设置错误了");
        
    }
    
    if ([self.arr_Config[indexPath.section] count]<=indexPath.row) {
        return [UITableViewCell new];
    }
    
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:self.arr_Config[indexPath.section][indexPath.row]];
    if (!cell) {
        
        cell = [(UITableViewCell *) [NSClassFromString(self.arr_Config[indexPath.section][indexPath.row]) alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:self.arr_Config[indexPath.section][indexPath.row]];
    }
    
    SEL myIndexPathGetMothon = NSSelectorFromString(@"myIndexPath");
    if ([cell respondsToSelector:myIndexPathGetMothon]) {
        [cell setValue:indexPath forKey:@"myIndexPath"];
    }
    
    
    SEL tableViewGetMothon = NSSelectorFromString(@"tableView");
    if ([cell respondsToSelector:tableViewGetMothon]) {
        [cell setValue:tableView forKey:@"tableView"];
    }
    
    SEL getMothon = NSSelectorFromString(@"params");
    
    if ([cell respondsToSelector:getMothon]) {
        [cell setValue:self.arr_dataSource[indexPath.section][indexPath.row] forKey:@"params"];
    }
    
    if (_cellAtIndexPath) {
        _cellAtIndexPath(cell,indexPath);
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

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (_arr_section.count==0) {
        return 0.001;
    }
    
    if (_arr_heads.count==0) {
        
        
        return [_arr_section[section] floatValue];
    }else{
        
        UIView * v = _arr_heads[section];
        NSDictionary * data = _arr_headData[section];
        
        
        [v updateConstraints];
        [v setNeedsUpdateConstraints];
        
        CGFloat height = [v systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height+1;
        
        [self setViewValueWith:data byView:v tag:(int)self.arr_heads.count];
        
        return height;
        
        
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section<_arr_heads.count) {
        
        UIView * v_head= _arr_heads[section];
        
        v_head.tag = section;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapHead:)];
        [v_head addGestureRecognizer:tap];
        
        
        return v_head;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.001;
    
    //    if ((_arr_Config.count-1) == section && self.arr_section.count>1) {
    //        long row = (long)[self.arr_dataSource[section] count];
    //        if (row==0) {
    //            return 0.0;
    //        }
    //
    //
    //        return 100.;
    //    }
    //
    //    return 0;
}


-(void)removeHeightByIndexPath:(NSIndexPath *)indexPath{
    
    NSString * key = [NSString stringWithFormat:@"qqqqqqqqqqqqqqqq-%ld,%ld",(long)indexPath.section,(long)indexPath.row];
    
    [self.dict_heightSave removeObjectForKey:key];
    
    
}
-(void)removeHeight{
    
    [self.dict_heightSave removeAllObjects];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * key = [NSString stringWithFormat:@"qqqqqqqqqqqqqqqq-%ld,%ld",(long)indexPath.section,(long)indexPath.row];
    
    if (self.dict_heightSave[key]) {
        return [self.dict_heightSave[key] floatValue];
    }
    
    
    if ([self.arr_Config count]<=indexPath.section) {
        
        return 44;
    }
    
    if ([self.arr_Config[indexPath.section] count]<=indexPath.row) {
        
        return 44;
    }
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:self.arr_Config[indexPath.section][indexPath.row]];
    
    
    if (!cell) {
        cell = [(UITableViewCell *) [NSClassFromString(self.arr_Config[indexPath.section][indexPath.row]) alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:self.arr_Config[indexPath.section][indexPath.row]];
    }
    //    [self setAllViewInCell:cell andIndexPath:indexPath];
    SEL myIndexPathGetMothon = NSSelectorFromString(@"myIndexPath");
    if ([cell respondsToSelector:myIndexPathGetMothon]) {
        [cell setValue:indexPath forKey:@"myIndexPath"];
    }
    
    SEL getMothon = NSSelectorFromString(@"params");
    if ([cell respondsToSelector:getMothon]) {
        
        [cell setValue:self.arr_dataSource[indexPath.section][indexPath.row] forKey:@"params"];
    }
    
    
    
    
    
    if (_cellAtIndexPath) {
        _cellAtIndexPath(cell,indexPath);
    }
    [cell.contentView layoutIfNeeded];
    [cell.contentView updateConstraints];
    [cell.contentView setNeedsUpdateConstraints];
    [cell.contentView updateConstraintsIfNeeded];
    CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    
    
    [self.dict_heightSave setObject:@(height) forKey:key];
    
    return height;
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
        NSLog(@"warning:没有集成DidSelectRowAtIndexPath block");
    }
    
    UITableViewCell * cell = [self cellForRowAtIndexPath:indexPath];
    if ([cell isKindOfClass:[CommonCell class]]) {
        
        
        CommonCell * commonCell = (CommonCell *)cell;
        [commonCell commonTableView:self inViewController:[self viewController] didSelectCellAtIndexPath:indexPath];
        
    }else{
        NSLog(@"warning:没有继承CommonCell");
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
        NSLog(@"warining:你的控件名字写错了");
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
            if ([self.arr_dataSource[indexPath.section][indexPath.row] valueForKeyPath:str_Meaning]) {
                id content = [self.arr_dataSource[indexPath.section][indexPath.row]  valueForKeyPath:str_Meaning];
                
                
                [self setViewValueStr_View:str_View str_Class:str_Class andContent:content andIndexPath:indexPath inCell:cell];
            }
            else{
                
                NSLog(@"waring:数据实体里面不包含--%@ 属性",str_Meaning);
                
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
            NSLog(@"warining:你的控件名字写错了");
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
            id value_object = self.arr_dataSource[indexPath.section][indexPath.row];
            
            if ([value_object valueForKeyPath:str_Meaning]) {
                [value_object setValue:text forKey:str_Meaning];
            }
            else{
                
                NSLog(@"waring:数据实体里面不包含--%@ 属性",str_Meaning);
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
            //                id object = weakSelf.arr_dataSource[indexPath.section][indexPath.row];
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
            //                id object = weakSelf.arr_dataSource[indexPath.section][indexPath.row];
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
                    
                    NSString * str_url = object;
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
    //    NSString * start = @"====== start ======";
    //    NSString * end = @"====== end ======";
    //
    //    NSLog(@"%@",start);
    //    NSLog(@"%@",obj);
    //获得所有的属性的名字
    for (NSString *key in [self propertyKeysWith:obj]) {
        
        //网络数据
        if ([dataSource isKindOfClass:[NSDictionary class]]) {
            ret = ([dataSource valueForKey:key]==nil)?NO:YES;
        }
        else
        {
            ret = [dataSource respondsToSelector:NSSelectorFromString(key)];
        }
        
        if (ret) {
            id propertyValue = [dataSource valueForKey:key];
            
            //该值不为NSNULL，并且也不为nil
            if (![propertyValue isKindOfClass:[NSNull class]] && propertyValue!=nil) {
                [obj setValue:propertyValue forKey:key];
                //                NSLog(@"key:%@,value:%@",key,propertyValue);
            }
            
        }
    }
    
    //    NSLog(@"%@",end);
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

/**
 *  检测字符串是否为空
 *
 *  @param str 目标字符串
 *
 *  @return 布尔值
 */
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

#pragma mark --delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    
    
    if (_cellAtIndexPathSendData) {
        _cellAtIndexPathSendData([self getViewCellByView:textField],[self getViewNsIndexPathByView:textField],textField,UITextFieldViewShouldBeginEditing,textField.text);
    }
    
    [self setObject:textField Value:textField.text InCell:[self getViewCellByView:textField] IndexPath:[self getViewNsIndexPathByView:textField]];
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (_cellAtIndexPathSendData) {
        _cellAtIndexPathSendData([self getViewCellByView:textField],[self getViewNsIndexPathByView:textField],textField,UITextFieldViewDidBeginEditing,textField.text);
    }
    [self setObject:textField Value:textField.text InCell:[self getViewCellByView:textField] IndexPath:[self getViewNsIndexPathByView:textField]];
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
    if (_cellAtIndexPathSendData) {
        _cellAtIndexPathSendData([self getViewCellByView:textField],[self getViewNsIndexPathByView:textField],textField,UITextFieldShouldEndEditing,textField.text);
    }
    
    
    [self setObject:textField Value:textField.text InCell:[self getViewCellByView:textField] IndexPath:[self getViewNsIndexPathByView:textField]];
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (_cellAtIndexPathSendData) {
        _cellAtIndexPathSendData([self getViewCellByView:textField],[self getViewNsIndexPathByView:textField],textField,UITextFieldDidEndEditing,textField.text);
    }
    
    [self setObject:textField Value:textField.text InCell:[self getViewCellByView:textField] IndexPath:[self getViewNsIndexPathByView:textField]];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (_cellAtIndexPathSendData) {
        _cellAtIndexPathSendData([self getViewCellByView:textField],[self getViewNsIndexPathByView:textField],textField,UITextFieldViewShouldChangeCharactersInRange,textField.text);
    }
    [self setObject:textField Value:textField.text InCell:[self getViewCellByView:textField] IndexPath:[self getViewNsIndexPathByView:textField]];
    return YES;
    
}
- (BOOL)textFieldShouldClear:(UITextField *)textField{
    
    if (_cellAtIndexPathSendData) {
        _cellAtIndexPathSendData([self getViewCellByView:textField],[self getViewNsIndexPathByView:textField],textField,UITextFieldViewShouldClear,textField.text);
    }
    [self setObject:textField Value:textField.text InCell:[self getViewCellByView:textField] IndexPath:[self getViewNsIndexPathByView:textField]];
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if (_cellAtIndexPathSendData) {
        _cellAtIndexPathSendData([self getViewCellByView:textField],[self getViewNsIndexPathByView:textField],textField,UITextFieldViewShouldReturn,textField.text);
    }
    [self setObject:textField Value:textField.text InCell:[self getViewCellByView:textField] IndexPath:[self getViewNsIndexPathByView:textField]];
    return YES;
}


#pragma mark -- tv
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    
    if (_cellAtIndexPathSendData) {
        _cellAtIndexPathSendData([self getViewCellByView:textView],[self getViewNsIndexPathByView:textView],textView,UITextFieldViewShouldBeginEditing,textView.text);
    }
    
    [self setObject:textView Value:textView.text InCell:[self getViewCellByView:textView] IndexPath:[self getViewNsIndexPathByView:textView]];
    return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    
    
    if (_cellAtIndexPathSendData) {
        _cellAtIndexPathSendData([self getViewCellByView:textView],[self getViewNsIndexPathByView:textView],textView,UITextFieldShouldEndEditing,textView.text);
    }
    [self setObject:textView Value:textView.text InCell:[self getViewCellByView:textView] IndexPath:[self getViewNsIndexPathByView:textView]];
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    
    if (_cellAtIndexPathSendData) {
        _cellAtIndexPathSendData([self getViewCellByView:textView],[self getViewNsIndexPathByView:textView],textView,UITextFieldViewDidBeginEditing,textView.text);
    }
    [self setObject:textView Value:textView.text InCell:[self getViewCellByView:textView] IndexPath:[self getViewNsIndexPathByView:textView]];
    
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    if (_cellAtIndexPathSendData) {
        _cellAtIndexPathSendData([self getViewCellByView:textView],[self getViewNsIndexPathByView:textView],textView,UITextFieldDidEndEditing,textView.text);
    }
    [self setObject:textView Value:textView.text InCell:[self getViewCellByView:textView] IndexPath:[self getViewNsIndexPathByView:textView]];
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if (_cellAtIndexPathSendData) {
        _cellAtIndexPathSendData([self getViewCellByView:textView],[self getViewNsIndexPathByView:textView],textView,UITextFieldViewShouldChangeCharactersInRange,textView.text);
    }
    [self setObject:textView Value:textView.text InCell:[self getViewCellByView:textView] IndexPath:[self getViewNsIndexPathByView:textView]];
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView{
    if (_cellAtIndexPathSendData) {
        _cellAtIndexPathSendData([self getViewCellByView:textView],[self getViewNsIndexPathByView:textView],textView,UITextViewDidChange,textView.text);
    }
    [self setObject:textView Value:textView.text InCell:[self getViewCellByView:textView] IndexPath:[self getViewNsIndexPathByView:textView]];
}

- (void)textViewDidChangeSelection:(UITextView *)textView{
    if (_cellAtIndexPathSendData) {
        _cellAtIndexPathSendData([self getViewCellByView:textView],[self getViewNsIndexPathByView:textView],textView,UITextViewDidChangeSelection,textView.text);
    }
    [self setObject:textView Value:textView.text InCell:[self getViewCellByView:textView] IndexPath:[self getViewNsIndexPathByView:textView]];
}



-(void)dealloc{
    
    //    [self removeAllObserver];
}

- (void)tapHead:(UITapGestureRecognizer *)sender {
    if (_didSelectSectionAtIndexPath) {
        _didSelectSectionAtIndexPath([NSIndexPath indexPathForRow:0 inSection:sender.view.tag]);
    }
}



//// 触摸
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [self endEditing:YES];
    [self.superview endEditing:YES];
    
    if (_didTouchTableView) {
        _didTouchTableView(self);
    }
    [super touchesBegan:touches withEvent:event];
}

-(void)addNibWithEntity:(id)object andCellName:(NSString *)cellName {
    
    
   if (![self.arr_Config[0] containsObject:cellName]&&![cellName isEqualToString:@"UITableViewCell"]) {
       [self setCellNibName:cellName andCellReuseIdentifier:cellName];
   }
    
    [self.arr_Config[0] addObject:cellName];
    [self.arr_dataSource[0] addObject:object];
    
    
    if (!_closeAutoReload) {
        [self reloadData];
    }
}

-(void)insertIndexPath:(NSIndexPath *)indexPath withNibWithEntity:(id)object andCellName:(NSString *)cellName withRowAnimation:(UITableViewRowAnimation)animation{
    
    
    if (![self.arr_Config[indexPath.section] containsObject:cellName]) {
        [self setCellNibName:cellName andCellReuseIdentifier:cellName];
    }
    
    [self.arr_Config[indexPath.section] insertObject:cellName atIndex:indexPath.row];
    [self.arr_dataSource[indexPath.section] insertObject:object atIndex:indexPath.row];
    
    [self removeHeight];
    
    [self beginUpdates];
    [self insertRowsAtIndexPaths:@[indexPath] withRowAnimation:animation];
    [self endUpdates];
}

-(void)removeIndexPath:(NSIndexPath *)indexPath andCellName:(NSString *)cellName withRowAnimation:(UITableViewRowAnimation)animation{
    
    @try {
        NSMutableArray * arr = self.arr_Config[indexPath.section];
        
        if ([arr[indexPath.row] isEqualToString:cellName]) {
            [arr removeObjectAtIndex:indexPath.row];
            [self.arr_dataSource[indexPath.section] removeObjectAtIndex:indexPath.row];
            [self removeHeightByIndexPath:indexPath];
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
        NSMutableArray * arr = self.arr_Config[indexPath.section];
        
        
        [arr removeObjectAtIndex:indexPath.row];
        [self.arr_dataSource[indexPath.section] removeObjectAtIndex:indexPath.row];
        
        
        [self removeHeight];
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

-(void)addClassWithEntity:(id)object andCellName:(NSString *)cellName {
    if (![self.arr_Config[0] containsObject:cellName]&&![cellName isEqualToString:@"UITableViewCell"]) {
        [self setCellClass:cellName andCellReuseIdentifier:cellName];
    }
    [self.arr_Config[0] addObject:cellName];
    [self.arr_dataSource[0] addObject:object];
    if (!_closeAutoReload) {
        [self reloadData];
    }
}

-(void)addNibWithEntity:(id)object andCellName:(NSString *)cellName andSection:(int)section {
    
    if (![self.arr_Config[section] containsObject:cellName]&&![cellName isEqualToString:@"UITableViewCell"]) {
        [self setCellNibName:cellName andCellReuseIdentifier:cellName];
    }
    [self.arr_Config[section] addObject:cellName];
    [self.arr_dataSource[section] addObject:object];
    if (!_closeAutoReload) {
        [self reloadData];
    }
}

-(void)addClassWithEntity:(id)object andCellName:(NSString *)cellName andSection:(int)section {
    if (![self.arr_Config[section] containsObject:cellName]&&![cellName isEqualToString:@"UITableViewCell"]) {
        [self setCellClass:cellName andCellReuseIdentifier:cellName];
    }
    [self.arr_Config[section] addObject:cellName];
    [self.arr_dataSource[section] addObject:object];
    if (!_closeAutoReload) {
        [self reloadData];
    }
}

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


//-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
//
//    UIView * view =[super hitTest:point withEvent:event];
//
//    UITableViewCell * cell = [self cellForRowAtIndexPath:[self indexPathForRowAtPoint:point]];
//    CGPoint newPoint = CGPointMake(point.x-cell.frame.origin.x, point.y-cell.frame.origin.y);
//    //拦截检查
//    for (UIView * vvv in self.arr_interceptObjectEvent) {
//
//         CGRect frame = [vvv.superview convertRect:vvv.frame toView:cell.contentView];
//
//        if (CGRectContainsPoint(frame, newPoint)) {
//
//
//            NSLog(@"tableView didselect拦截成功！！");
//            if (ARR_ISNOT_NIL(vvv.gestureRecognizers)) {
//
//                for (UIGestureRecognizer * gest in vvv.gestureRecognizers) {
//                    NSString * str_action = gest.description;
//
//                    NSRange range = [str_action rangeOfString:@"target= <(action="];
//                    NSRange range1 = [str_action rangeOfString:@", target="];
//
//                    if (range.length==0||range1.length==0) {
//                        return nil;
//                    }
//
//                    long a0 = range.location+range.length;
//                    long a1 = range1.location;
//
//                    NSRange rang3 = NSMakeRange(a0, a1-a0);
//
//                    NSString * action = [str_action substringWithRange:rang3];
//                    SEL sel_action = NSSelectorFromString(action);
//                    if ([cell respondsToSelector:sel_action]) {
//                         NSLog(@"tableView didselect拦截成功后转为改控件的手势事件");
//                        [cell performSelector:sel_action withObject:gest];
//                    }
//
//
//                }
//            }
//
//            //进行拦截
//            return nil;
//        }
//
//    }
//
//
//
//
//    return view;
//}
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


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    UIViewController*viewController=[UtilCommon viewController:self];
//    [viewController.view endEditing:YES];
}



@end
