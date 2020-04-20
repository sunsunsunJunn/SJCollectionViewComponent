//
//  SJCollectionViewCellProtocol.h
//  SJCollectionViewComponent
//
//  Created by SUNJUN on 2020/3/16.
//  Copyright © 2020 SUNJUN. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol SJCollectionViewCellModelProtocol;
@class SJCollectionViewSection;

NS_ASSUME_NONNULL_BEGIN

/**
 * collectionView Cell 配置协议
 */
@protocol SJCollectionViewCellProtocol <NSObject>

@optional

/**
 * 传递数据给 cell (根据配置对象拿到数据更新UI)
 * @param cellModel 配置对象
 * @param indexPath indexPath
 */
- (void)sj_configureCellWithCellModel:(id<SJCollectionViewCellModelProtocol>)cellModel indexPath:(NSIndexPath *)indexPath;

/**
 * 传递数据给 cell (根据配置对象拿到数据更新UI)
 * @param cellModel 配置对象
 */
- (void)sj_configureCellWithCellModel:(id<SJCollectionViewCellModelProtocol>)cellModel;

/**
 * 当前 cell 被选中
 *
 * @param indexPath indexPath
 */
- (void)sj_didSelectedAtIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
