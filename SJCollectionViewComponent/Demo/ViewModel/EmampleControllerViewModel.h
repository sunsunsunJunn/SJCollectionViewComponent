//
//  EmampleControllerViewModel.h
//  SJCollectionViewComponent
//
//  Created by SUNJUN on 2020/3/17.
//  Copyright © 2020 SUNJUN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TestDataModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface EmampleControllerViewModel : NSObject

/// 开始网络请求
- (void)startRequestWithSuccess:(void(^)(NSArray<TestDataModel *> *modelArray))success;

@end

NS_ASSUME_NONNULL_END
