//
//  SJCollectionViewHeaderFooterModelProtocol.h
//  SJCollectionViewComponent
//
//  Created by SUNJUN on 2020/3/16.
//  Copyright © 2020 SUNJUN. All rights reserved.
//

#import "SJCollectionViewHeaderFooterProtocol.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * collectionView HeaderFooter Model 配置协议
 */
@protocol SJCollectionViewHeaderFooterModelProtocol <NSObject>

@required

/** header/footer 类类型 */
- (Class<SJCollectionViewHeaderFooterProtocol>)sj_headerFooterClass;

- (CGSize)sj_headerFooterSize;

@optional

/** header/footer 对应的数据模型 */
- (id)sj_heaerFooterModel;

/** header/footer 的复用标识 */
- (NSString *)sj_headerFooterReuseIdentifier;

@end

NS_ASSUME_NONNULL_END
