//
//  TestTwoCellModel.h
//  SJCollectionViewComponent
//
//  Created by SUNJUN on 2020/3/17.
//  Copyright © 2020 SUNJUN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UICollectionView+SJComponent.h"
#import "TestDataModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TestTwoCellModel : NSObject <SJCollectionViewCellModelProtocol>

@property (nonatomic, copy) NSString *detailTitle;

@property (nonatomic, strong, readonly) TestDataModel *dataModel;

+ (instancetype)cellModelWithDataModel:(TestDataModel *)dataModel;

@end

NS_ASSUME_NONNULL_END
