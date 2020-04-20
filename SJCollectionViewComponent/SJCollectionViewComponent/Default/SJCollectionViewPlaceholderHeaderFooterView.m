//
//  SJCollectionViewPlaceholderHeaderFooterView.m
//  SJCollectionViewComponent
//
//  Created by SUNJUN on 2020/4/20.
//  Copyright © 2020 SUNJUN. All rights reserved.
//

#import "SJCollectionViewPlaceholderHeaderFooterView.h"
#import "SJCollectionViewPlaceholderHeaderFooterModel.h"

@implementation SJCollectionViewPlaceholderHeaderFooterView

#pragma mark - SJCollectionViewHeaderFooterProtocol

- (void)sj_configureHeaderFooterWithHeaderFooterModel:(id<SJCollectionViewHeaderFooterModelProtocol>)headerFooterModel {
  SJCollectionViewPlaceholderHeaderFooterModel *placeholderModel = headerFooterModel;
  self.backgroundColor = placeholderModel.backgroundColor;
}

@end
