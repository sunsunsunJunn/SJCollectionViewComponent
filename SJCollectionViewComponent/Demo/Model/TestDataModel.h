//
//  TestDataModel.h
//  SJCollectionViewComponent
//
//  Created by SUNJUN on 2020/3/17.
//  Copyright © 2020 SUNJUN. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, TestDataModelType) {
    TestDataModelTypeOne,
    TestDataModelTypeTwo,
};

@interface TestDataModel : NSObject

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *detailTitle;

@property (nonatomic, assign) TestDataModelType type;

@end

NS_ASSUME_NONNULL_END
