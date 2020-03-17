//
//  TestTwoCellModel.m
//  SJCollectionViewComponent
//
//  Created by SUNJUN on 2020/3/17.
//  Copyright © 2020 SUNJUN. All rights reserved.
//

#import "TestTwoCellModel.h"
#import "TestTwoCell.h"

@interface TestTwoCellModel ()

@property (nonatomic, strong) TestDataModel *dataModel;

@end

@implementation TestTwoCellModel

+ (instancetype)cellModelWithDataModel:(TestDataModel *)dataModel {
  TestTwoCellModel *cellModel = [[TestTwoCellModel alloc] init];
  cellModel.dataModel = dataModel;
  cellModel.detailTitle = dataModel.detailTitle;
  return cellModel;
}

#pragma mark - SJCollectionViewCellModelProtocol

- (Class<SJCollectionViewCellProtocol>)sj_cellClass {
  return TestTwoCell.class;
}

- (CGSize)sj_cellSize {
  //可以根据模型数据 计算出size 这里只是演示固定了
  return CGSizeMake(([UIScreen mainScreen].bounds.size.width - 20)/2 - 3, 200);
}

@end
