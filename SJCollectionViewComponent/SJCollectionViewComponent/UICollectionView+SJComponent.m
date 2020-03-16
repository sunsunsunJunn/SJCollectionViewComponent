//
//  UICollectionView+SJComponent.m
//  SJCollectionViewComponent
//
//  Created by SUNJUN on 2020/3/16.
//  Copyright © 2020 SUNJUN. All rights reserved.
//

#import "UICollectionView+SJComponent.h"
#import <objc/runtime.h>

@implementation UICollectionView (SJComponent)

- (NSMutableArray<id<SJCollectionViewCellModelProtocol>> *)sj_singleSectionRowArray {
  return self.sj_firstSection.rowArray;
}

- (void)setSj_singleSectionHeader:(id<SJCollectionViewHeaderFooterModelProtocol>)sj_singleSectionHeader {
  self.sj_firstSection.header = sj_singleSectionHeader;
}

- (id<SJCollectionViewHeaderFooterModelProtocol>)sj_singleSectionHeader {
  return self.sj_firstSection.header;
}

- (void)setSj_singleSectionFooter:(id<SJCollectionViewHeaderFooterModelProtocol>)sj_singleSectionFooter {
  self.sj_firstSection.footer = sj_singleSectionFooter;
}

- (id<SJCollectionViewHeaderFooterModelProtocol>)sj_singleSectionFooter {
  return self.sj_firstSection.footer;
}

- (void)setSj_singleSectionMinimumLineSpacing:(CGFloat)sj_singleSectionMinimumLineSpacing {
  self.sj_firstSection.minimumLineSpacing = sj_singleSectionMinimumLineSpacing;
}

- (CGFloat)sj_singleSectionMinimumLineSpacing {
  return self.sj_firstSection.minimumLineSpacing;
}

- (void)setSj_singleSectionMinimumInteritemSpacing:(CGFloat)sj_singleSectionMinimumInteritemSpacing {
  self.sj_firstSection.minimumInteritemSpacing = sj_singleSectionMinimumInteritemSpacing;
}

- (CGFloat)sj_singleSectionMinimumInteritemSpacing {
  return self.sj_firstSection.minimumInteritemSpacing;
}

- (void)setSj_singleSectionInset:(UIEdgeInsets)sj_singleSectionInset {
  self.sj_firstSection.inset = sj_singleSectionInset;
}

- (UIEdgeInsets)sj_singleSectionInset {
  return self.sj_firstSection.inset;
}

- (SJCollectionViewSection *)sj_firstSection {
    if (self.sj_sectionArray.count > 0) {
        return self.sj_sectionArray[0];
    }
    SJCollectionViewSection *section = [SJCollectionViewSection new];
    [self.sj_sectionArray addObject:section];
    return section;
}

- (id<SJCollectionViewCellModelProtocol>)cellModelForIndexPath:(NSIndexPath *)indexPath {
  return [self.sj_collectionImplement cellModelForIndexPath:indexPath];
}

- (NSIndexPath *)indexPathForCellModel:(id<SJCollectionViewCellModelProtocol>)cellModel {
  return [self.sj_collectionImplement indexPathForCellModel:cellModel];
}

#pragma mark - getters & setters
- (void)setSj_sectionArray:(NSMutableArray<SJCollectionViewSection *> * _Nonnull)sj_sectionArray {
  objc_setAssociatedObject(self, @selector(sj_sectionArray), sj_sectionArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// 初始化流程 sj_sectionArray - > setSj_sectionArray -> sj_collectionImplement -> setSj_collectionImplement
- (NSMutableArray<SJCollectionViewSection *> *)sj_sectionArray {
  NSMutableArray *array = objc_getAssociatedObject(self, _cmd);
  if (!array) {
    array = [NSMutableArray array];
    self.sj_sectionArray = array;
    
    [self sj_collectionImplement];
  }
  return array;
}

- (void)setSj_collectionImplement:(__kindof SJCollectionViewImplement *)sj_collectionImplement {
  sj_collectionImplement.sectionArray = self.sj_sectionArray;
  self.delegate = sj_collectionImplement;
  self.dataSource = sj_collectionImplement;
  
  __weak typeof(self) wSelf = self;
  sj_collectionImplement.didSelectItenAtIndexPathBlock = ^(UICollectionView * _Nonnull collectionView, NSIndexPath * _Nonnull indexPath) {
    __strong typeof(wSelf) self = wSelf;
    if (self.sj_didSelectItemAtIndexPathBlock) {
      self.sj_didSelectItemAtIndexPathBlock(collectionView, indexPath);
    }
  };
  
  objc_setAssociatedObject(self, @selector(sj_collectionImplement), sj_collectionImplement, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (SJCollectionViewImplement *)sj_collectionImplement {
  SJCollectionViewImplement *imp = objc_getAssociatedObject(self, _cmd);
  if (!imp) {
      imp = [SJCollectionViewImplement new];
      self.sj_collectionImplement = imp;
  }
  return imp;
}


- (void (^)(UICollectionView * _Nonnull, NSIndexPath * _Nonnull))sj_didSelectItemAtIndexPathBlock {
  return objc_getAssociatedObject(self, _cmd);
}

- (void)setSj_didSelectItemAtIndexPathBlock:(void (^)(UICollectionView * _Nonnull, NSIndexPath * _Nonnull))sj_didSelectItemAtIndexPathBlock {
  objc_setAssociatedObject(self, @selector(setSj_didSelectItemAtIndexPathBlock:), sj_didSelectItemAtIndexPathBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
