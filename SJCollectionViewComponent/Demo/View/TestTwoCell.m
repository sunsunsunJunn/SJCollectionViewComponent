//
//  TestTwoCell.m
//  SJCollectionViewComponent
//
//  Created by SUNJUN on 2020/3/17.
//  Copyright © 2020 SUNJUN. All rights reserved.
//

#import "TestTwoCell.h"
#import "TestTwoCellModel.h"

@interface TestTwoCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@end

@implementation TestTwoCell

- (void)awakeFromNib {
  [super awakeFromNib];
  // Initialization code
  self.contentView.backgroundColor = [UIColor grayColor];
}

#pragma mark - SJCollectionViewCellProtocol

- (void)sj_configureCellWithCellModel:(id<SJCollectionViewCellModelProtocol>)cellModel {
  TestTwoCellModel *testTwoCellModel = cellModel;
  
  self.detailLabel.text = testTwoCellModel.detailTitle;
}

@end
