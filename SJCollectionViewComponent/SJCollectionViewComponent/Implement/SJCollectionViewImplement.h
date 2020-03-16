//
//  SJCollectionViewImplement.h
//  SJCollectionViewComponent
//
//  Created by SUNJUN on 2020/3/16.
//  Copyright © 2020 SUNJUN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SJCollectionViewSection.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * UICollectionView中间代理实现类，delegate datasource 统一在此处理
 * 实现了部分代理会回调方法满足大部分需求 若想实现更多的代理方法，继承于该类在子类中拓展就行了。
 */
@interface SJCollectionViewImplement : NSObject <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

/** 数据源 */
@property (nonatomic, strong) NSMutableArray<SJCollectionViewSection *> *sectionArray;

/**
 * 获取indexPath 对应的cellModel
 */
- (id<SJCollectionViewCellModelProtocol>)cellModelForIndexPath:(NSIndexPath *)indexPath;

/**
 * 获取cellModel 对应的indexPath
 */
- (NSIndexPath *)indexPathForCellModel:(id<SJCollectionViewCellModelProtocol>)cellModel;

/**
 * collectionVIew将要配置cell的回调(可在此设置一些cell的其他属性)
 */
@property (nonatomic, copy) void(^willConfigureCellAtIndexPathBlock)(UICollectionViewCell *cell, NSIndexPath *indexPath);

/**
 * collectionView 点击的回调每一个item的回调
 */
@property (nonatomic, copy) void(^didSelectItenAtIndexPathBlock)(UICollectionView *collectionView, NSIndexPath *indexPath);

@end

NS_ASSUME_NONNULL_END
