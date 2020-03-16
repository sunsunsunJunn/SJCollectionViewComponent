//
//  UICollectionView+SJComponent.h
//  SJCollectionViewComponent
//
//  Created by SUNJUN on 2020/3/16.
//  Copyright © 2020 SUNJUN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SJCollectionViewImplement.h"

NS_ASSUME_NONNULL_BEGIN

@interface UICollectionView (SJComponent)

/** 一个 section，cell 配置数组 */
@property (nonatomic, strong, readonly) NSMutableArray<id<SJCollectionViewCellModelProtocol>> *sj_singleSectionRowArray;

/** 一个 section，header 配置 */
@property (nonatomic, strong, nullable) id<SJCollectionViewHeaderFooterModelProtocol> sj_singleSectionHeader;

/** 一个 section，footer 配置 */
@property (nonatomic, strong, nullable) id<SJCollectionViewHeaderFooterModelProtocol> sj_singleSectionFooter;

/** 一个 section，cell 间距 */
@property (nonatomic, assign) CGFloat sj_singleSectionMinimumLineSpacing;

/** 一个 section，cell 间距 */
@property (nonatomic, assign) CGFloat sj_singleSectionMinimumInteritemSpacing;

/** 一个 section，外边距 */
@property (nonatomic, assign) UIEdgeInsets sj_singleSectionInset;

/** 多个 section */
@property (nonatomic, strong, readonly) NSMutableArray<SJCollectionViewSection *> *sj_sectionArray;

/** 代理实现者，将数组内容转换为列表代理方法的核心类
 （需要实现额外的 UICollectionView 代理方法，可以自定义继承 YBHandyTableIMP 的类并赋值该属性）*/
@property (nonatomic, strong) __kindof SJCollectionViewImplement *sj_collectionImplement;

/**
 * collectionView 点击的回调每一个cell的回调
 */
@property (nonatomic, copy) void(^sj_didSelectItemAtIndexPathBlock)(UICollectionView *collectionView, NSIndexPath *indexPath);

/**
 * 获取indexPath 对应的cellModel
 */
- (id<SJCollectionViewCellModelProtocol>)cellModelForIndexPath:(NSIndexPath *)indexPath;

/**
  * 获取cellModel 对应的indexPath
  */
- (NSIndexPath *)indexPathForCellModel:(id<SJCollectionViewCellModelProtocol>)cellModel;

@end

NS_ASSUME_NONNULL_END
