//
//  SJCollectionViewCellModelProtocol.h
//  SJCollectionViewComponent
//
//  Created by SUNJUN on 2020/3/16.
//  Copyright © 2020 SUNJUN. All rights reserved.
//

#import "SJCollectionViewCellProtocol.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * collectionView CellModel 配置协议
 */
@protocol SJCollectionViewCellModelProtocol <NSObject>

@required

/** cell 的类类型 */
- (Class<SJCollectionViewCellProtocol>)sj_cellClass;

/** cell 大小 */
- (CGSize)sj_cellSize;

@optional

/** cell 对应的数据模型 */
- (id)sj_model;

/** sj_cellClass对应的复用标识 不设置的话默认是 sj_cellClass对应的string */
- (NSString *)sj_cellReuseIdentifier;

@end

NS_ASSUME_NONNULL_END
