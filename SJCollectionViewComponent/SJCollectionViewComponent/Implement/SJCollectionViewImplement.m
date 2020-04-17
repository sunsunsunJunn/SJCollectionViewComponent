//
//  SJCollectionViewImplement.m
//  SJCollectionViewComponent
//
//  Created by SUNJUN on 2020/3/16.
//  Copyright © 2020 SUNJUN. All rights reserved.
//

#import "SJCollectionViewImplement.h"

@interface SJCollectionViewImplement ()

@property (nonatomic, strong) NSMutableSet *reuseCellSet;
@property (nonatomic, strong) NSMutableSet *reuseHeaderSet;
@property (nonatomic, strong) NSMutableSet *reuseFooterSet;

@end

@implementation SJCollectionViewImplement

- (instancetype)init {
  if (self = [super init]) {
    _reuseCellSet = [NSMutableSet set];
    _reuseHeaderSet = [NSMutableSet set];
    _reuseFooterSet = [NSMutableSet set];
  }
  return self;
}

#pragma mark - Public Methods

- (id<SJCollectionViewCellModelProtocol>)cellModelForIndexPath:(NSIndexPath *)indexPath {
  if (!self.sectionArray.count) {
    return nil;
  }
  
  SJCollectionViewSection *secionModel = self.sectionArray[indexPath.section];
  
  if (![secionModel isKindOfClass:[SJCollectionViewSection class]]) {
    return nil;
  }
  
  if (secionModel.rowArray.count <= indexPath.item) {
    return nil;
  }
  
  return secionModel.rowArray[indexPath.item];
}

- (NSIndexPath *)indexPathForCellModel:(id<SJCollectionViewCellModelProtocol>)cellModel {
  NSIndexPath *indexPath = nil;
  
  for (int i = 0; i < self.sectionArray.count; i++) {
    NSArray *rowArray = self.sectionArray[i].rowArray;
    if ([rowArray containsObject:cellModel]) {
      NSInteger rowIndex = [rowArray indexOfObject:cellModel];
      indexPath = [NSIndexPath indexPathForItem:rowIndex inSection:i];
      break;
    }
  }

  return indexPath;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return self.sectionArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return self.sectionArray[section].rowArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  SJCollectionViewSection *sjSection = self.sectionArray[indexPath.section];
  id<SJCollectionViewCellModelProtocol> cellModel = sjSection.rowArray[indexPath.row];
  
  Class cellClass = [self validClassForCellModel:cellModel];
  NSString *identifier = [self reuseIdentifierForCellModel:cellModel];
  
  if (![_reuseCellSet containsObject:identifier]) {
    NSString *path = [[NSBundle mainBundle] pathForResource:NSStringFromClass(cellClass) ofType:@"nib"];
    if (path) {
        [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass(cellClass) bundle:nil] forCellWithReuseIdentifier:identifier];
    } else {
        [collectionView registerClass:cellClass forCellWithReuseIdentifier:identifier];
    }
    [_reuseCellSet addObject:identifier];
  }
  
  UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
  
  if (self.cellForItemAtIndexPathBlock) {
    self.cellForItemAtIndexPathBlock(cell, indexPath);
  }
  
  if ([cell conformsToProtocol:@protocol(SJCollectionViewCellProtocol)]) {
    UICollectionViewCell<SJCollectionViewCellProtocol> *tmpCell = (UICollectionViewCell<SJCollectionViewCellProtocol> *)cell;
    
    if ([tmpCell respondsToSelector:@selector(sj_configureCellWithCellModel:)]) {
      [tmpCell sj_configureCellWithCellModel:cellModel];
    }
    
    if ([tmpCell respondsToSelector:@selector(sj_configureCellWithCellModel:indexPath:)]) {
      [tmpCell sj_configureCellWithCellModel:cellModel indexPath:indexPath];
    }
  }
  
  return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
  SJCollectionViewSection *sjSection = self.sectionArray[indexPath.section];

  id<SJCollectionViewHeaderFooterModelProtocol> headerFooterModel;
  NSMutableSet *reuseSet;
  if (kind == UICollectionElementKindSectionHeader) {
      headerFooterModel = sjSection.header;
      reuseSet = _reuseHeaderSet;
  } else if (kind == UICollectionElementKindSectionFooter) {
      headerFooterModel = sjSection.footer;
      reuseSet = _reuseFooterSet;
  } else {
      return nil;
  }
  
  Class cls = [self validClassForHeaderFooterModel:headerFooterModel];
  NSString *identifier = [self reuseIdentifierForHeaderFooterModel:headerFooterModel];
  
  if (![reuseSet containsObject:identifier]) {
      NSString *path = [[NSBundle mainBundle] pathForResource:NSStringFromClass(cls) ofType:@"nib"];
      if (path) {
          [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass(cls) bundle:nil] forSupplementaryViewOfKind:kind withReuseIdentifier:identifier];
      } else {
          [collectionView registerClass:cls forSupplementaryViewOfKind:kind withReuseIdentifier:identifier];
      }
      [reuseSet addObject:identifier];
  }
  
  UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:identifier forIndexPath:indexPath];
  
  if ([view conformsToProtocol:@protocol(SJCollectionViewHeaderFooterProtocol)]) {
    UICollectionReusableView<SJCollectionViewHeaderFooterProtocol> *tmpView = (UICollectionReusableView<SJCollectionViewHeaderFooterProtocol> *)view;
    
    if ([tmpView respondsToSelector:@selector(sj_configureCellWithCellModel:indexPath:)]) {
      [tmpView sj_configureHeaderFooterWithHeaderFooterModel:headerFooterModel indexPath:indexPath];
    }
    
    if ([tmpView respondsToSelector:@selector(sj_configureHeaderFooterWithHeaderFooterModel:)]) {
      [tmpView sj_configureHeaderFooterWithHeaderFooterModel:headerFooterModel];
    }
  }
  
  return view;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
  if ([cell respondsToSelector:@selector(sj_didSelectedAtIndexPath:)]) {
    [(id<SJCollectionViewCellProtocol>)cell sj_didSelectedAtIndexPath:indexPath];
  }
  
  if (self.didSelectItenAtIndexPathBlock) {
    self.didSelectItenAtIndexPathBlock(collectionView, indexPath);
  }
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  SJCollectionViewSection *sjSection = self.sectionArray[indexPath.section];
  id<SJCollectionViewCellModelProtocol> cellModel = sjSection.rowArray[indexPath.row];
  
  if ([cellModel respondsToSelector:@selector(sj_cellSize)] && !CGSizeEqualToSize(cellModel.sj_cellSize, CGSizeZero)) {
    return [cellModel sj_cellSize];
  }
  
  return CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
  SJCollectionViewSection *sjSection = self.sectionArray[section];
  id<SJCollectionViewHeaderFooterModelProtocol> headerFooterModel = sjSection.header;
  
  if ([headerFooterModel respondsToSelector:@selector(sj_headerFooterSize)] && !CGSizeEqualToSize(headerFooterModel.sj_headerFooterSize, CGSizeZero)) {
    return [headerFooterModel sj_headerFooterSize];
  }
  
  return CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
  SJCollectionViewSection *sjSection = self.sectionArray[section];
  id<SJCollectionViewHeaderFooterModelProtocol> headerFooterModel = sjSection.footer;
  
  if ([headerFooterModel respondsToSelector:@selector(sj_headerFooterSize)]) {
    return [headerFooterModel sj_headerFooterSize];
  }
  
  return CGSizeZero;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
  return self.sectionArray[section].minimumLineSpacing;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
  return self.sectionArray[section].minimumInteritemSpacing;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
  return self.sectionArray[section].inset;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  if (self.scrollViewDidScrollBlock) {
    self.scrollViewDidScrollBlock(scrollView);
  }
}

#pragma mark - Private Methods

- (Class)validClassForCellModel:(id<SJCollectionViewCellModelProtocol>)cellModel {
    return cellModel.sj_cellClass ?: UICollectionViewCell.self;
}

- (Class)validClassForHeaderFooterModel:(id<SJCollectionViewHeaderFooterModelProtocol>)headerFooterModel {
    return headerFooterModel.sj_headerFooterClass ?: UICollectionReusableView.self;
}

- (NSString *)reuseIdentifierForCellModel:(id<SJCollectionViewCellModelProtocol>)cellModel {
  NSString *identifier;
  if (cellModel && [cellModel respondsToSelector:@selector(sj_cellReuseIdentifier)]) {
    identifier = cellModel.sj_cellReuseIdentifier;
  }
  
  return identifier ?: NSStringFromClass([self validClassForCellModel:cellModel]);
}

- (NSString *)reuseIdentifierForHeaderFooterModel:(id<SJCollectionViewHeaderFooterModelProtocol>)headerFooterModel {
  NSString *identifier;
  if (headerFooterModel && [headerFooterModel respondsToSelector:@selector(sj_headerFooterReuseIdentifier)]) {
    identifier = headerFooterModel.sj_headerFooterReuseIdentifier;
  }
  
  return identifier ?: NSStringFromClass([self validClassForHeaderFooterModel:headerFooterModel]);
}

#pragma mark - getter

- (NSMutableArray<SJCollectionViewSection *> *)sectionArray {
    if (!_sectionArray) {
        _sectionArray = [NSMutableArray array];
    }
    return _sectionArray;
}

@end
