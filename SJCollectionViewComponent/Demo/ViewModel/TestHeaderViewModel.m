//
//  TestHeaderViewModel.m
//  SJCollectionViewComponent
//
//  Created by SUNJUN on 2020/3/17.
//  Copyright © 2020 SUNJUN. All rights reserved.
//

#import "TestHeaderViewModel.h"
#import "TestHeaderView.h"

@implementation TestHeaderViewModel

#pragma mark - SJCollectionViewHeaderFooterModelProtocol

- (Class<SJCollectionViewHeaderFooterProtocol>)sj_headerFooterClass {
  return TestHeaderView.class;
}

- (CGSize)sj_headerFooterSize {
  return CGSizeMake([UIScreen mainScreen].bounds.size.width, 30);
}

@end
