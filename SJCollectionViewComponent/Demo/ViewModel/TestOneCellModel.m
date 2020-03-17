//
//  TestOneCellModel.m
//  SJCollectionViewComponent
//
//  Created by SUNJUN on 2020/3/17.
//  Copyright © 2020 SUNJUN. All rights reserved.
//

#import "TestOneCellModel.h"
#import "TestOneCell.h"

@interface TestOneCellModel ()

@property (nonatomic, strong) TestDataModel *dataModel;

@end

@implementation TestOneCellModel

+ (instancetype)cellModelWithDataModel:(TestDataModel *)dataModel {
  TestOneCellModel *cellModel = [[TestOneCellModel alloc] init];
  cellModel.dataModel = dataModel;
  cellModel.title = dataModel.title;
  cellModel.detailTitle = dataModel.detailTitle;
  return cellModel;
}

#pragma mark - SJCollectionViewCellModelProtocol

- (Class<SJCollectionViewCellProtocol>)sj_cellClass {
  return TestOneCell.class;
}

- (CGSize)sj_cellSize {
  //可以根据模型数据 计算出size 这里只是演示固定了
  return CGSizeMake(([UIScreen mainScreen].bounds.size.width - 20)/2 - 3, 200);
}

@end
