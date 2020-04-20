//
//  SJCollectionViewPlaceholderHeaderFooterModel.m
//  SJCollectionViewComponent
//
//  Created by SUNJUN on 2020/4/20.
//  Copyright © 2020 SUNJUN. All rights reserved.
//

#import "SJCollectionViewPlaceholderHeaderFooterModel.h"
#import "SJCollectionViewPlaceholderHeaderFooterView.h"

@implementation SJCollectionViewPlaceholderHeaderFooterModel

- (instancetype)init {
  if (self = [super init]) {
    _backgroundColor = [UIColor whiteColor];
    _size = CGSizeMake([UIScreen mainScreen].bounds.size.width, 10);
  }
  return self;
}

#pragma mark - SJCollectionViewHeaderFooterModelProtocol

- (Class<SJCollectionViewHeaderFooterProtocol>)sj_headerFooterClass {
  return SJCollectionViewPlaceholderHeaderFooterView.class;
}

- (CGSize)sj_headerFooterSize {
  return self.size;
}

@end
