//
//  ExampleViewController.m
//  SJCollectionViewComponent
//
//  Created by SUNJUN on 2020/3/2.
//  Copyright © 2020 SUNJUN. All rights reserved.
//

#import "ExampleViewController.h"
#import "EmampleControllerViewModel.h"
#import "UICollectionView+SJComponent.h"
#import "TestOneCellModel.h"
#import "TestTwoCellModel.h"
#import "TestHeaderViewModel.h"
#import "SJCollectionViewPlaceholderHeaderFooterModel.h"

@interface ExampleViewController ()

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) EmampleControllerViewModel *viewModel;

@end

@implementation ExampleViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor whiteColor];
  [self.view addSubview:self.collectionView];
  
  [self loadData];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
  self.collectionView.frame = self.view.bounds;
}

- (void)dealloc {
  NSLog(@"%@ dealloc", [self class]);
}

- (void)loadData {
  // 加载数据
  [self.viewModel startRequestWithSuccess:^(NSArray<TestDataModel *> * _Nonnull modelArray) {
    
    NSMutableArray *viewModelArray = [NSMutableArray array];
    NSMutableArray *sectionArray = [NSMutableArray array];
    for (TestDataModel *dataModel in modelArray) {
      switch (dataModel.type) {
        case TestDataModelTypeOne: {
          TestOneCellModel *oneCellModel = [TestOneCellModel cellModelWithDataModel:dataModel];
          
          //cell点击事件
          oneCellModel.oneCellClickedBlock = ^{
            NSLog(@"点击按钮");
          };
          [viewModelArray addObject:oneCellModel];
          
          SJCollectionViewSection *section = [[SJCollectionViewSection alloc] init];
          section.header = [[TestHeaderViewModel alloc] init];
          section.footer = [[TestHeaderViewModel alloc] init];
          [section.rowArray addObject:oneCellModel];
          [sectionArray addObject:section];
        }
          break;
          
        case TestDataModelTypeTwo: {
          TestTwoCellModel *twoCellModel = [TestTwoCellModel cellModelWithDataModel:dataModel];
          [viewModelArray addObject:twoCellModel];
          
          SJCollectionViewSection *section = [[SJCollectionViewSection alloc] init];
          section.header = [[TestHeaderViewModel alloc] init];
          section.footer = [[TestHeaderViewModel alloc] init];
          [section.rowArray addObject:twoCellModel];
          [sectionArray addObject:section];
        }
          break;
      }
    }
    
    // 设置数据源 一个section
    SJCollectionViewPlaceholderHeaderFooterModel *headerModel = [[SJCollectionViewPlaceholderHeaderFooterModel alloc] init];
    headerModel.backgroundColor = [UIColor blueColor];
    headerModel.size = CGSizeMake(self.view.bounds.size.width, 20);
    self.collectionView.sj_oneSectionHeader = headerModel;
    self.collectionView.sj_oneSectionFooter = [[TestHeaderViewModel alloc] init];
    self.collectionView.sj_oneSectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    self.collectionView.sj_oneSectionMinimumLineSpacing = 10;
    self.collectionView.sj_oneSectionMinimumInteritemSpacing = 4;
    [self.collectionView.sj_oneSectionRowArray addObjectsFromArray:viewModelArray];
    
    //多个section
//    [self.collectionView.sj_sectionArray addObjectsFromArray:sectionArray];
    
    //刷新列表
    [self.collectionView reloadData];
  }];
}

#pragma mark - getter

- (UICollectionView *)collectionView {
  if (!_collectionView) {
    UICollectionViewFlowLayout *layout = UICollectionViewFlowLayout.new;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionView.backgroundColor = UIColor.whiteColor;
    _collectionView.sj_didSelectItemAtIndexPathBlock = ^(UICollectionView * _Nonnull collectionView, NSIndexPath * _Nonnull indexPath) {
      NSLog(@"点击了第%ld个", (long)indexPath.item);
    };
    _collectionView.sj_scrollViewDidScrollBlock = ^(UIScrollView * _Nonnull scrollView) {
      NSLog(@"滑动%f", scrollView.contentOffset.y);
    };
  }
  return _collectionView;
}

- (EmampleControllerViewModel *)viewModel {
  if (!_viewModel) {
    _viewModel = [[EmampleControllerViewModel alloc] init];
  }
  return _viewModel;
}

@end
