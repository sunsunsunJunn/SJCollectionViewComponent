//
//  SJCollectionViewSection.h
//  SJCollectionViewComponent
//
//  Created by SUNJUN on 2020/3/16.
//  Copyright © 2020 SUNJUN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SJCollectionViewHeaderFooterModelProtocol.h"
#import "SJCollectionViewCellModelProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface SJCollectionViewSection : NSObject

/** UICollectionView 的 header 配置 */
@property (nonatomic, strong, nullable) id<SJCollectionViewHeaderFooterModelProtocol> header;

/** UICollectionView 的 footer 配置 */
@property (nonatomic, strong, nullable) id<SJCollectionViewHeaderFooterModelProtocol> footer;

/** UICollectionView 的 cell 配置数组 */
@property (nonatomic, strong, readonly) NSMutableArray<id<SJCollectionViewCellModelProtocol>> *rowArray;

/** cell 间距 */
@property (nonatomic, assign) CGFloat minimumLineSpacing;

/** cell 间距 */
@property (nonatomic, assign) CGFloat minimumInteritemSpacing;

/** section 外边距 */
@property (nonatomic, assign) UIEdgeInsets inset;

@end

NS_ASSUME_NONNULL_END
