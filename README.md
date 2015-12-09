# CommonTableCollectView
通用型tableViewCollectView


#  Cocoapods 

 pod 'CommonTableCollectView', '~> 0.0.1'

# 作者以及联系方式

梁殿熊  liangdianxiong@163.com

cong   harde1@163.com

# 最简单的使用方法

 [tableView/collectionView addNibWithEntity:_params(参数对象) andCellName:NSStringFromClass([Cell_Posted_Text(cell的类) class])];


tablView继承于CommonTableView,不要写代理delegate,一句都不要。
约束遵守一个口诀：
最顶和最底与cell.contentView的想接触的控件分别只能有一个。
简单来说就是不能有高度歧义


#  优点

优点是：

        1、一句代码做完3问1答，代码少

        2、面向对象，对象自己负责所有关于自己的事情，cell负责数据处理提取，cell负责事件绑定

        3、tableView/collectView与controler脱离，cell与tableView/collectView脱离，好处是cell到那里vc的tableView/collectView，事件和相关的东西都会跟着过去，不会搞乱代码

        4、不用写delegate,dataSource,千万不要写，写了就无效了，不要写协议，直接使用


#  使用方式

一、添加cell和cell相对应的数据源进入tableView/collectionView，andSection:0不写就默认为section == 0


        1、本库采用的是新式的自动布局，低版本不支持6.0以下的，7.0可能也有点问题

        2、既然采用自动布局，那么高度是不用计算的，自动处理，所以cell的约束一定不能有歧义，有歧义，布局会刷不出来

        3、cell要继承于Commoncell/CommonCollectionCell，因为这cell里面我加了不少东西

        4、tableView/collectionVie要继承于CommonTableView和CommonCollectionView

好了怎么使用？

        [tableView/collectionView addNibWithEntity:_params(参数对象) andCellName:NSStringFromClass([Cell_Posted_Text(cell的类) class])];

就这样一句，就完成了一个cell添加完成了，连reloadData也不需要了！！！
你说你有强迫症，还是需要reloadData,那么要关闭自动reloadData

tableView/collectionView.closeAutoReload = YES;

另外的就是插入哪一个section里面去

        [tableView/collectionView addNibWithEntity:_params(参数对象) andCellName:NSStringFromClass([Cell_Posted_Text(cell的类) class]) andSection:0];

        [tableView/collectionView addNibWithEntity:_params(参数对象) andCellName:NSStringFromClass([Cell_Posted_Text(cell的类) class]) andSection:1];

        [tableView/collectionView addNibWithEntity:_params(参数对象) andCellName:NSStringFromClass([Cell_Posted_Text(cell的类) class]) andSection:2];

二、cellAtIndexPath和didSelectRowAtIndexPath相应代码放在那里？



        [tableView commonTableViewCellAtIndexPath:^(UITableViewCell *cell, NSIndexPath *indexPath) {

        //相关事件CellAtIndexPath，在这里写跟系统原来的一样

        } andDidSelectRowAtIndexPath:^(NSIndexPath *indexPath) {

        //didselect事件

        }];

但是我不推荐这样写，因为我认为面向对象的世界观就是，自己的事情自己做，cell的CellforXXXAtIndexPath事件，一般是数据提取，didselect是cell的点击事件，
度应该放在cell的类里面自己完成，所以应该这样写：

在cell的类里面，因为父类Commoncell/CommonCollectionCell有参数



        @interface CommonCell : UITableViewCell
        @property(strong,nonatomic)id params;
        @property(strong,nonatomic)NSIndexPath * myIndexPath;
        @property(weak,nonatomic)CommonTableView * tableView;


        -(void)commonTableView:(CommonTableView *)tableView inViewController:(UIViewController *)viewController didSelectCellAtIndexPath:(NSIndexPath *)indexPath;

        -(void)commonTableView:(CommonTableView *)tableView inViewController:(UIViewController *)viewController cellForIndexPath:(NSIndexPath *)indexPath;
        //编辑模式B
        - (void)commonTableView:(CommonTableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;
        @end

基本在cell里面可以拿到viewcontroller,tableView,params,indexPath所有的参数，所以为何不在这些方法里面实现？

好处是什么呢？这样写的好处，最简单的就是移植度高，耦合低，通用性强，一个cell在多个地方不用处理太多就能使用，出错了，问题也很精确的找到相对应的文件


三、关于section的header的高度设置

        tableView.arr_Sections = @[@(20),@(30),@(40)];//意思就是section == 0,高度是20，section == 1高度是30……

四、获取cell里面的承载的数据数组

        tableView.arr_dataSource[indexpath.section][indexpath.row];//意思就是第几个section，第几个cell上面的数据

五、清除所有cell和数据

        [tableView clearAllData];

六、清除缓存的高度，因为高度计算影响效率，所以高度是有缓存的，有同学用了该库，想改动某个cell高度大小不成功，就是因为没有清除高度缓存

        //移除indexPath的cell的高度缓存
        -(void)removeHeightByIndexPath:(NSIndexPath *)indexPath;

        //移除所有高度缓存
        -(void)removeHeight;


七、插入和删除一个cell

        //插入一个cell
        -(void)insertIndexPath:(NSIndexPath *)indexPath withNibWithEntity:(id)object andCellName:(NSString *)cellName withRowAnimation:(UITableViewRowAnimation)animation;

        //移除一个cell
        -(void)removeIndexPath:(NSIndexPath *)indexPath andCellName:(NSString *)cellName withRowAnimation:(UITableViewRowAnimation)animation;

        -(void)removeIndexPath:(NSIndexPath *)indexPath withRowAnimation:(UITableViewRowAnimation)animation;


八、编辑模式
        //UITableViewCellEditingStyle 有三种模式，删除模式，插入模式，普通模式（默认）
        
        -(void)addNibWithEntity:(id)obj andCellName:(NSString *)cellName editStyle:(UITableViewCellEditingStyle)editStyle;

        -(void)addClassWithEntity:(id)obj andCellName:(NSString *)cellName editStyle:(UITableViewCellEditingStyle)editStyle;
        //指定编辑模式的section
        -(void)addNibWithEntity:(id)obj andCellName:(NSString *)cellName editStyle:(UITableViewCellEditingStyle)editStyle andSection:(int)section;

        -(void)addClassWithEntity:(id)obj andCellName:(NSString *)cellName editStyle:(UITableViewCellEditingStyle)editStyle andSection:(int)section;

        //编辑模式事件响应
        //编辑模式事件处理A，CommonTableView的block方法块里面可以实现编辑事件
        -(void)setCommitEditingAtIndexPath:(CommitEditingAtIndexPath)commitEditingAtIndexPath;


        //编辑模式事件响应B，cell继承CommonCell之后，以下方法里面会给调用
        - (void)commonTableView:(CommonTableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;
