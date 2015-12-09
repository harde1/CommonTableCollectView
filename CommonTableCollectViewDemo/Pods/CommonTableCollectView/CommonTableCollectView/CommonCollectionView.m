//
//  CommonCollectionView.m
//  CollectIonViewTest
//
//  Created by cong on 15/10/5.
//  Copyright © 2015年 cong. All rights reserved.
//
#import "CommonCollectionView.h"
#import "CommonRView.h"
@implementation CommonCollectionView
#pragma mark 初始化
- (instancetype)init{
    self = [super init];
    if (self) {
        //省略
        self.delegate = self;
        self.dataSource = self;
        if (!_arr_dataSource) {
            self.arr_dataSource = [@[[@[] mutableCopy]]mutableCopy];
        }
        if (!_arr_identifierConfig) {
            self.arr_identifierConfig = [@[[@[] mutableCopy]]mutableCopy];
        }
        if (!_dict_dataSourceHeader) {
            _dict_dataSourceHeader = [@{}mutableCopy];
        }
        if (!_dict_identifierHeader) {
            _dict_identifierHeader = [@{}mutableCopy];
        }
        if (!_dict_insetForSection) {
            self.dict_insetForSection = [@{} mutableCopy];
        }
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        //省略
        self.delegate = self;
        self.dataSource = self;
        if (!_arr_dataSource) {
            self.arr_dataSource = [@[[@[] mutableCopy]]mutableCopy];
        }
        if (!_arr_identifierConfig) {
            self.arr_identifierConfig = [@[[@[] mutableCopy]]mutableCopy];
        }
        if (!_dict_dataSourceHeader) {
            _dict_dataSourceHeader = [@{}mutableCopy];
        }
        if (!_dict_identifierHeader) {
            _dict_identifierHeader = [@{}mutableCopy];
        }
        if (!_dict_insetForSection) {
            self.dict_insetForSection = [@{} mutableCopy];
        }
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        //省略
        self.delegate = self;
        self.dataSource = self;
        if (!_arr_dataSource) {
            self.arr_dataSource = [@[[@[] mutableCopy]]mutableCopy];
        }
        if (!_arr_identifierConfig) {
            self.arr_identifierConfig = [@[[@[] mutableCopy]]mutableCopy];
        }
        if (!_dict_dataSourceHeader) {
            _dict_dataSourceHeader = [@{}mutableCopy];
        }
        if (!_dict_identifierHeader) {
            _dict_identifierHeader = [@{}mutableCopy];
        }
        if (!_dict_insetForSection) {
            self.dict_insetForSection = [@{} mutableCopy];
        }
    }
    return self;
}
-(NSMutableDictionary *)dict_heightSave{
    if (!_dict_heightSave) {
        _dict_heightSave = [@{}mutableCopy];
    }
    return _dict_heightSave;
}
-(NSMutableDictionary *)dict_headerSizeSave{
    if (!_dict_headerSizeSave) {
        _dict_headerSizeSave = [@{}mutableCopy];
    }
    return _dict_headerSizeSave;
}
#pragma mark 添加cell
//注册cell ,第一步
-(void)setCellClass:(NSString *)str_CellName andCellReuseIdentifier:(NSString *)str_Identifier{
    [self registerClass:NSClassFromString(str_CellName) forCellWithReuseIdentifier:str_Identifier];
}
-(void)setCellNibName:(NSString *)str_CellName andCellReuseIdentifier:(NSString *)str_Identifier{
    [self registerNib:[UINib nibWithNibName:str_CellName bundle:nil] forCellWithReuseIdentifier:str_Identifier];
}
//第二步加入cell
-(void)addNibWithEntity:(id)str_Object andCellName:(NSString *)cellName {
    [self addNibWithEntity:str_Object andCellName:cellName andSection:0];
}
-(void)addClassWithEntity:(id)object andCellName:(NSString *)cellName {
    [self addClassWithEntity:object andCellName:cellName andSection:0];
}
-(void)addNibWithEntity:(id)object andCellName:(NSString *)cellName andSection:(int)section {
    for (int i=0; i<=section; i++) {
        if (section>=self.arr_identifierConfig.count) {
            [self.arr_identifierConfig addObject:[@[]mutableCopy]];
        }
        if (section>=self.arr_dataSource.count) {
            [self.arr_dataSource addObject:[@[]mutableCopy]];
        }
    }
    if (![self.arr_identifierConfig[section] containsObject:cellName]&&![cellName isEqualToString:@"UICollectionViewCell"]) {
        [self setCellNibName:cellName andCellReuseIdentifier:cellName];
    }
    [self.arr_identifierConfig[section] addObject:cellName];
    [self.arr_dataSource[section] addObject:object];
    if (!_closeAutoReload) {
        [self reloadData];
    }
}
-(void)addClassWithEntity:(id)object andCellName:(NSString *)cellName andSection:(int)section {
    for (int i=0; i<=section; i++) {
        if (section>=self.arr_identifierConfig.count) {
            [self.arr_identifierConfig addObject:[@[]mutableCopy]];
        }
        if (section>=self.arr_dataSource.count) {
            [self.arr_dataSource addObject:[@[]mutableCopy]];
        }
    }
    if (![self.arr_identifierConfig[section] containsObject:cellName]&&![cellName isEqualToString:@"UICollectionViewCell"]) {
        [self setCellClass:cellName andCellReuseIdentifier:cellName];
    }
    [self.arr_identifierConfig[section] addObject:cellName];
    [self.arr_dataSource[section] addObject:object];
    if (!_closeAutoReload) {
        [self reloadData];
    }
}
//完善UICollectionViewDelegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.arr_dataSource.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.arr_dataSource[section] count];
}
//设置元素内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell =[collectionView dequeueReusableCellWithReuseIdentifier:self.arr_identifierConfig[indexPath.section][indexPath.row] forIndexPath:indexPath];
    SEL myIndexPathGetMothon = NSSelectorFromString(@"myIndexPath");
    if ([cell respondsToSelector:myIndexPathGetMothon]) {
        [cell setValue:indexPath forKey:@"myIndexPath"];
    }
    SEL getMothon = NSSelectorFromString(@"params");
    if ([cell respondsToSelector:getMothon]) {
        [cell setValue:self.arr_dataSource[indexPath.section][indexPath.row] forKey:@"params"];
    }
    if (_collectionViewCellAtIndexPath) {
        _collectionViewCellAtIndexPath(cell,indexPath);
    }
    if ([cell isKindOfClass:[CommonCollectionCell class]]) {
        CommonCollectionCell * commonCollectionCell = (CommonCollectionCell *)cell;
        [commonCollectionCell commonCollectionView:self inViewController:[self viewController] cellForIndexPath:indexPath];
    }else{
        //        NSLog(@"warning:没有继承CommonCell");
    }
    return cell;
}
//设置元素的的大小框
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    //每个section一个
    NSString * insetKey = [NSString stringWithFormat:@"section-%ld",(long)section];
    if (!self.dict_insetForSection[insetKey]) {
        return UIEdgeInsetsZero;
    }
    //上下左右
    UIEdgeInsets top = UIEdgeInsetsFromString(self.dict_insetForSection[insetKey]);
    return top;
}
//设置单元格宽度
//设置元素大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (!CGSizeEqualToSize(_itemSize, CGSizeZero)) {
        return _itemSize;
    }
    CGSize size = CGSizeZero;
    NSString * key = [NSString stringWithFormat:@"UICollectionView-%ld,%ld",(long)indexPath.section,(long)indexPath.row];
    if (self.dict_heightSave[key]) {
        size =CGSizeFromString(self.dict_heightSave[key]);
        return size;
    }
    UICollectionViewCell * cell;
    if (!_cell_temp) {
        _cell_temp =[[[NSBundle mainBundle]loadNibNamed:self.arr_identifierConfig[indexPath.section][indexPath.row]  owner:self options:nil] lastObject];
    }
    cell = self.cell_temp;
    SEL myIndexPathGetMothon = NSSelectorFromString(@"myIndexPath");
    if ([cell respondsToSelector:myIndexPathGetMothon]) {
        [cell setValue:indexPath forKey:@"myIndexPath"];
    }
    SEL getMothon = NSSelectorFromString(@"params");
    if ([cell respondsToSelector:getMothon]) {
        [cell setValue:self.arr_dataSource[indexPath.section][indexPath.row] forKey:@"params"];
    }
    if (_collectionViewCellAtIndexPath) {
        _collectionViewCellAtIndexPath(cell,indexPath);
    }
    [cell.contentView layoutIfNeeded];
    [cell.contentView updateConstraints];
    [cell.contentView setNeedsUpdateConstraints];
    [cell.contentView updateConstraintsIfNeeded];
    size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    [self.dict_heightSave setObject:NSStringFromCGSize(size) forKey:key];
    return size;
}
//互动
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (_didSelectItemAtIndexPath) {
        _didSelectItemAtIndexPath(indexPath);
    }else{
        //            NSLog(@"warning:没有集成_didSelectItemAtIndexPath block");
    }
    UICollectionViewCell * cell = [self cellForItemAtIndexPath:indexPath];
    if ([cell isKindOfClass:[CommonCollectionCell class]]) {
        CommonCollectionCell * commonCollectionCell = (CommonCollectionCell *)cell;
        [commonCollectionCell commonCollectionView:self inViewController:[self viewController] didSelectCellAtIndexPath:indexPath];
    }else{
        //            NSLog(@"warning:没有继承CommonCell");
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
//// 触摸
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self endEditing:YES];
    [self.superview endEditing:YES];
    if (_didTouchCollectionView) {
        _didTouchCollectionView(self);
    }
    [super touchesBegan:touches withEvent:event];
}
-(void)clearAllData{
    if (self.arr_identifierConfig) {
        for (int i=0;i<self.arr_identifierConfig.count;i++) {
            self.arr_identifierConfig[i] = [@[]mutableCopy];
        }
    }
    if (self.arr_dataSource) {
        for (int i=0;i<self.arr_dataSource.count;i++) {
            self.arr_dataSource[i] = [@[]mutableCopy];
        }
    }
    [self.dict_heightSave removeAllObjects];
}
-(void)removeSizeByIndexPath:(NSIndexPath *)indexPath{
    NSString * key = [NSString stringWithFormat:@"UICollectionView-%ld,%ld",(long)indexPath.section,(long)indexPath.row];
    [self.dict_heightSave removeObjectForKey:key];
}
-(void)removeSize{
    [self.dict_heightSave removeAllObjects];
}
-(void)insertIndexPath:(NSIndexPath *)indexPath withNibWithEntity:(id)object andCellName:(NSString *)cellName{
    //    if (![self.arr_identifierConfig[indexPath.section] containsObject:cellName]) {
    [self setCellNibName:cellName andCellReuseIdentifier:cellName];
    //    }
    [self.arr_identifierConfig[indexPath.section] insertObject:cellName atIndex:indexPath.row];
    [self.arr_dataSource[indexPath.section] insertObject:object atIndex:indexPath.row];
    [self removeSize];
    [self insertItemsAtIndexPaths:@[indexPath]];
}
-(void)removeIndexPath:(NSIndexPath *)indexPath andCellName:(NSString *)cellName{
    @try {
        NSMutableArray * arr = self.arr_identifierConfig[indexPath.section];
        if ([arr[indexPath.row] isEqualToString:cellName]) {
            [arr removeObjectAtIndex:indexPath.row];
            [self.arr_dataSource[indexPath.section] removeObjectAtIndex:indexPath.row];
            [self removeSizeByIndexPath:indexPath];
            [self deleteItemsAtIndexPaths:@[indexPath]];
        }
    }
    @catch (NSException *exception) {
        NSLog(@"@warning: %@",exception);
    }
    @finally {
    }
}
-(void)removeIndexPath:(NSIndexPath *)indexPath{
    @try {
        NSMutableArray * arr = self.arr_identifierConfig[indexPath.section];
        [arr removeObjectAtIndex:indexPath.row];
        [self.arr_dataSource[indexPath.section] removeObjectAtIndex:indexPath.row];
        [self removeSize];
        [self deleteItemsAtIndexPaths:@[indexPath]];
    }
    @catch (NSException *exception) {
        NSLog(@"@warning: %@",exception);
    }
    @finally {
    }
}
#pragma mark didSelect和itemforIndexpath的block
-(void)commonCollectionViewCellAtIndexPath:(CollectionViewCellAtIndexPath)collectionViewCellAtIndexPath andDidSelectRowAtIndexPath:(DidSelectItemAtIndexPath)didSelectItemAtIndexPath {
    _collectionViewCellAtIndexPath = collectionViewCellAtIndexPath;
    _didSelectItemAtIndexPath = didSelectItemAtIndexPath;
}
-(void)setViewForSupplementaryElementOfKindInSection:(ViewForSupplementaryElementOfKindInSection)viewForSupplementaryElementOfKindInSection{
    _viewForSupplementaryElementOfKindInSection = viewForSupplementaryElementOfKindInSection;
}
-(void)addHeaderNibWithEntity:(id)str_Object andViewName:(NSString *)viewName andSection:(int)section {
    NSString * key = [NSString stringWithFormat:@"%@-%d",UICollectionElementKindSectionHeader,section];
    [self registerNib:[UINib nibWithNibName:viewName bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:viewName];
    self.dict_identifierHeader[key] = viewName;
    self.dict_dataSourceHeader[key] = str_Object;
    if (!_closeAutoReload) {
        [self reloadData];
    }
}
-(void)addHeaderClassWithEntity:(id)str_Object andViewName:(NSString *)viewName andSection:(int)section {
    NSString * key = [NSString stringWithFormat:@"%@-%d",UICollectionElementKindSectionHeader,section];
    [self registerClass:NSClassFromString(viewName) forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:viewName];
    self.dict_identifierHeader[key] = viewName;
    self.dict_dataSourceHeader[key] = str_Object;
    if (!_closeAutoReload) {
        [self reloadData];
    }
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    NSString * key = [NSString stringWithFormat:@"%@-%ld",UICollectionElementKindSectionHeader,(long)indexPath.section];
    NSString * viewName = self.dict_identifierHeader[key];
    if (!viewName) {
        return nil;
    }
    UICollectionReusableView * rev = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:viewName forIndexPath:indexPath];
    if ([rev isKindOfClass:[CommonRView class]]) {
        CommonRView * rev2 = (CommonRView *)rev;
        rev2.section = indexPath.section;
        rev2.params = self.dict_dataSourceHeader[key];
    }
    if (_viewForSupplementaryElementOfKindInSection) {
        _viewForSupplementaryElementOfKindInSection(rev,UICollectionElementKindSectionHeader,indexPath.section);
    }
    if ([rev isKindOfClass:[CommonRView class]]) {
        CommonRView * rev2 = (CommonRView *)rev;
        [rev2 commonCollectionView:self inViewController:[self viewController] viewForSupplementaryElementOfKind:UICollectionElementKindSectionHeader inSection:indexPath.section];
    }
    return rev;
}
//返回头headerView的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    NSString * key = [NSString stringWithFormat:@"%@-%ld",UICollectionElementKindSectionHeader,(long)section];
    NSString * viewName = self.dict_identifierHeader[key];
    CGSize size = CGSizeZero;
    if (!viewName) {
        return size;
    }
    if (!CGSizeEqualToSize(_headSize, CGSizeZero)) {
        return _headSize;
    }
    NSString * key2 = [NSString stringWithFormat:@"UICollectionViewHead-%ld",(long)section];
    if (self.dict_headerSizeSave[key]) {
        size =CGSizeFromString(self.dict_headerSizeSave[key2]);
        return size;
    }
    //    if (!_revTemp) {
    _revTemp = [[[NSBundle mainBundle]loadNibNamed:viewName owner:self options:nil] firstObject];
    //    }
    if ([_revTemp isKindOfClass:[CommonRView class]]) {
        CommonRView * rev = (CommonRView *)_revTemp;
        rev.section = section;
        rev.params = self.dict_dataSourceHeader[key];
    }
    if (_viewForSupplementaryElementOfKindInSection) {
        _viewForSupplementaryElementOfKindInSection(_revTemp,UICollectionElementKindSectionHeader,section);
    }
    if ([_revTemp isKindOfClass:[CommonRView class]]) {
        CommonRView * rev = (CommonRView *)_revTemp;
        [rev commonCollectionView:self inViewController:[self viewController] viewForSupplementaryElementOfKind:UICollectionElementKindSectionHeader inSection:section];
    }
    [_revTemp layoutIfNeeded];
    [_revTemp updateConstraints];
    [_revTemp setNeedsUpdateConstraints];
    [_revTemp updateConstraintsIfNeeded];
    size = [_revTemp systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    [self.dict_headerSizeSave setObject:NSStringFromCGSize(size) forKey:key];
    return size;
}
-(void)setSection:(NSInteger)section withInset:(UIEdgeInsets)inset {
    NSString * insetKey = [NSString stringWithFormat:@"section-%ld",(long)section];
    self.dict_insetForSection[insetKey] = NSStringFromUIEdgeInsets(inset);
}
-(void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    if (_moveItemAtIndexPath) {
        _moveItemAtIndexPath(collectionView,sourceIndexPath,destinationIndexPath);
    }
}
-(void)setMoveItemAtIndexPath:(MoveItemAtIndexPath)moveItemAtIndexPath{
    _moveItemAtIndexPath = moveItemAtIndexPath;
}
-(void)moveItemFromIndexPath:(NSIndexPath *)fromIndexPath toNewIndexPath:(NSIndexPath *)newIndexPath andBlock:(void(^)(NSInteger state))stateBlock{
    @try {
        stateBlock(0);
        [self removeSize];
        id temp = self.arr_dataSource[fromIndexPath.section][fromIndexPath.item];
        id identifier = self.arr_identifierConfig[fromIndexPath.section][fromIndexPath.item];
        [self.arr_identifierConfig[fromIndexPath.section] removeObjectAtIndex:fromIndexPath.row];
        [self.arr_dataSource[fromIndexPath.section] removeObjectAtIndex:fromIndexPath.row];
        [self.arr_dataSource[newIndexPath.section] insertObject:temp atIndex:newIndexPath.item];
        [self.arr_identifierConfig[newIndexPath.section] insertObject:identifier atIndex:newIndexPath.item];
        [self moveItemAtIndexPath:fromIndexPath toIndexPath:newIndexPath];
        [self reloadData];
        stateBlock(1);
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception);
    }
    @finally {
    }
}
@end
