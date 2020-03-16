//
//  SJCollectionViewHeaderFooterProtocol.h
//  SJCollectionViewComponent
//
//  Created by SUNJUN on 2020/3/16.
//  Copyright © 2020 SUNJUN. All rights reserved.
//

@protocol SJCollectionViewHeaderFooterModelProtocol;

NS_ASSUME_NONNULL_BEGIN

/**
 * collectionView HeaderFooter 配置协议
 */
@protocol SJCollectionViewHeaderFooterProtocol <NSObject>

/**
 * 传递数据给 header/footer (根据配置对象拿到数据更新UI)
 *
 * @param headerFooterModel 配置对象
 * @param indexPath indexPath
 */
- (void)sj_configureHeaderFooterWithHeaderFooterModel:(id<SJCollectionViewHeaderFooterModelProtocol>)headerFooterModel indexPath:(NSIndexPath *)indexPath;

/**
 * 传递数据给 header/footer (根据配置对象拿到数据更新UI)
 *
 * @param headerFooterModel 配置对象
 */
- (void)sj_configureHeaderFooterWithHeaderFooterModel:(id<SJCollectionViewHeaderFooterModelProtocol>)headerFooterModel;

@end

NS_ASSUME_NONNULL_END
