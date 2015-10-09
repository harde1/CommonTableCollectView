# CommonTableCollectView
通用型tableViewCollectView

#  使用方式

一、添加cell和cell相对应的数据源进入tableView/collectionView，andSection:0不写就默认为section == 0
  1、本库采用的是新式的自动布局，低版本不支持6.0以下的，7.0可能也有点问题
  2、既然采用自动布局，那么高度是不用计算的，自动处理，所以cell的约束一定不能有歧义，有歧义，布局会刷不出来
  3、cell要继承于Commoncell/CommonCollectionCell，因为这cell里面我加了不少东西


[tableView/collectionView addNibWithEntity:_params(参数对象) andCellName:NSStringFromClass([Cell_Posted_Text(cell的类) class]) andSection:0];
