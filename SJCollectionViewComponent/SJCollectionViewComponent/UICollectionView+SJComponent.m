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

- (NSMutableArray<id<SJCollectionViewCellModelProtocol>> *)sj_oneSectionRowArray {
  return self.sj_firstSection.rowArray;
}

- (void)setSj_oneSectionHeader:(id<SJCollectionViewHeaderFooterModelProtocol>)sj_oneSectionHeader {
  self.sj_firstSection.header = sj_oneSectionHeader;
}

- (id<SJCollectionViewHeaderFooterModelProtocol>)sj_oneSectionHeader {
  return self.sj_firstSection.header;
}

- (void)setSj_oneSectionFooter:(id<SJCollectionViewHeaderFooterModelProtocol>)sj_oneSectionFooter {
  self.sj_firstSection.footer = sj_oneSectionFooter;
}

- (id<SJCollectionViewHeaderFooterModelProtocol>)sj_oneSectionFooter {
  return self.sj_firstSection.footer;
}

- (void)setSj_oneSectionMinimumLineSpacing:(CGFloat)sj_oneSectionMinimumLineSpacing {
  self.sj_firstSection.minimumLineSpacing = sj_oneSectionMinimumLineSpacing;
}

- (CGFloat)sj_oneSectionMinimumLineSpacing {
  return self.sj_firstSection.minimumLineSpacing;
}

- (void)setSj_oneSectionMinimumInteritemSpacing:(CGFloat)sj_oneSectionMinimumInteritemSpacing {
  self.sj_firstSection.minimumInteritemSpacing = sj_oneSectionMinimumInteritemSpacing;
}

- (CGFloat)sj_oneSectionMinimumInteritemSpacing {
  return self.sj_firstSection.minimumInteritemSpacing;
}

- (void)setSj_oneSectionInset:(UIEdgeInsets)sj_oneSectionInset {
  self.sj_firstSection.inset = sj_oneSectionInset;
}

- (UIEdgeInsets)sj_oneSectionInset {
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
  sj_collectionImplement.didSelectItemAtIndexPathBlock = ^(UICollectionView * _Nonnull collectionView, NSIndexPath * _Nonnull indexPath) {
    __strong typeof(wSelf) self = wSelf;
    if (self.sj_didSelectItemAtIndexPathBlock) {
      self.sj_didSelectItemAtIndexPathBlock(collectionView, indexPath);
    }
  };
  
  sj_collectionImplement.cellForItemAtIndexPathBlock = ^(UICollectionViewCell * _Nonnull cell, NSIndexPath * _Nonnull indexPath) {
    __strong typeof(wSelf) self = wSelf;
    if (self.sj_cellForItemAtIndexPathBlock) {
      self.sj_cellForItemAtIndexPathBlock(cell, indexPath);
    }
  };
  
  sj_collectionImplement.scrollViewDidScrollBlock = ^(UIScrollView * _Nonnull scrollView) {
    __strong typeof(wSelf) self = wSelf;
    if (self.sj_scrollViewDidScrollBlock) {
      self.sj_scrollViewDidScrollBlock(scrollView);
    }
  };
  
  sj_collectionImplement.willDisplayCellForItemAtIndexPathBlock = ^(UICollectionView * _Nonnull collectionView, UICollectionViewCell * _Nonnull cell, NSIndexPath * _Nonnull indexPath) {
    __strong typeof(wSelf) self = wSelf;
    if (self.sj_willDisplayCellForItemAtIndexPathBlock) {
      self.sj_willDisplayCellForItemAtIndexPathBlock(collectionView, cell, indexPath);
    }
  };
  
  sj_collectionImplement.didEndDisplayingCellForItemAtIndexPathBlock = ^(UICollectionView * _Nonnull collectionView, UICollectionViewCell * _Nonnull cell, NSIndexPath * _Nonnull indexPath) {
    __strong typeof(wSelf) self = wSelf;
    if (self.sj_didEndDisplayingCellForItemAtIndexPathBlock) {
      self.sj_didEndDisplayingCellForItemAtIndexPathBlock(collectionView, cell, indexPath);
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
  objc_setAssociatedObject(self, @selector(sj_didSelectItemAtIndexPathBlock), sj_didSelectItemAtIndexPathBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(UICollectionViewCell * _Nonnull, NSIndexPath * _Nonnull))sj_cellForItemAtIndexPathBlock {
  return objc_getAssociatedObject(self, _cmd);
}

- (void)setSj_cellForItemAtIndexPathBlock:(void (^)(UICollectionViewCell * _Nonnull, NSIndexPath * _Nonnull))sj_cellForItemAtIndexPathBlock {
  objc_setAssociatedObject(self, @selector(sj_cellForItemAtIndexPathBlock), sj_cellForItemAtIndexPathBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(UIScrollView * _Nonnull))sj_scrollViewDidScrollBlock {
  return objc_getAssociatedObject(self, _cmd);
}

- (void)setSj_scrollViewDidScrollBlock:(void (^)(UIScrollView * _Nonnull))sj_scrollViewDidScrollBlock {
  objc_setAssociatedObject(self, @selector(sj_scrollViewDidScrollBlock), sj_scrollViewDidScrollBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(UICollectionView * _Nonnull, UICollectionViewCell * _Nonnull, NSIndexPath * _Nonnull))sj_willDisplayCellForItemAtIndexPathBlock {
  return objc_getAssociatedObject(self, _cmd);
}

- (void)setSj_willDisplayCellForItemAtIndexPathBlock:(void (^)(UICollectionView * _Nonnull, UICollectionViewCell * _Nonnull, NSIndexPath * _Nonnull))sj_willDisplayCellForItemAtIndexPathBlock {
  objc_setAssociatedObject(self, @selector(sj_willDisplayCellForItemAtIndexPathBlock), sj_willDisplayCellForItemAtIndexPathBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(UICollectionView * _Nonnull, UICollectionViewCell * _Nonnull, NSIndexPath * _Nonnull))sj_didEndDisplayingCellForItemAtIndexPathBlock {
  return objc_getAssociatedObject(self, _cmd);
}

- (void)setSj_didEndDisplayingCellForItemAtIndexPathBlock:(void (^)(UICollectionView * _Nonnull, UICollectionViewCell * _Nonnull, NSIndexPath * _Nonnull))sj_didEndDisplayingCellForItemAtIndexPathBlock {
  objc_setAssociatedObject(self, @selector(sj_didEndDisplayingCellForItemAtIndexPathBlock), sj_didEndDisplayingCellForItemAtIndexPathBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
