//
//  TestOneCell.m
//  SJCollectionViewComponent
//
//  Created by SUNJUN on 2020/3/17.
//  Copyright © 2020 SUNJUN. All rights reserved.
//

#import "TestOneCell.h"
#import "TestOneCellModel.h"

@interface TestOneCell ()

@property (nonatomic, strong) TestOneCellModel *testOneCellModel;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@end

@implementation TestOneCell

- (void)awakeFromNib {
  [super awakeFromNib];
  // Initialization code
  self.contentView.backgroundColor = [UIColor cyanColor];
}

- (IBAction)buttonClicked:(id)sender {
  if (self.testOneCellModel.oneCellClickedBlock) {
    self.testOneCellModel.oneCellClickedBlock();
  }
}

#pragma mark - SJCollectionViewCellProtocol

- (void)sj_configureCellWithCellModel:(id<SJCollectionViewCellModelProtocol>)cellModel {
  self.testOneCellModel = cellModel;
  
  self.titleLabel.text = self.testOneCellModel.title;
  self.detailLabel.text = self.testOneCellModel.detailTitle;
}

@end
