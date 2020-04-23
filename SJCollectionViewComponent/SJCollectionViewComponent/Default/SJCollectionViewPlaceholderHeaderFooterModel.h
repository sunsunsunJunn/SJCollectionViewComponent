//
//  SJCollectionViewPlaceholderHeaderFooterModel.h
//  SJCollectionViewComponent
//
//  Created by SUNJUN on 2020/4/20.
//  Copyright © 2020 SUNJUN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SJCollectionViewHeaderFooterModelProtocol.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * 配置默认样式实现类，用于快速构建占位HeaderFooter
 * 样式: 带有颜色的占位headerFooterView
 */
@interface SJCollectionViewPlaceholderHeaderFooterModel : NSObject <SJCollectionViewHeaderFooterModelProtocol>

/** 背景颜色，默认:白色 */
@property (nonatomic, strong) UIColor *backgroundColor;

/** size 默认 w:屏幕宽 h:10 */
@property (nonatomic, assign) CGSize size;

@end

NS_ASSUME_NONNULL_END
