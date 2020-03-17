//
//  EmampleControllerViewModel.m
//  SJCollectionViewComponent
//
//  Created by SUNJUN on 2020/3/17.
//  Copyright © 2020 SUNJUN. All rights reserved.
//

#import "EmampleControllerViewModel.h"

@implementation EmampleControllerViewModel

- (void)startRequestWithSuccess:(void(^)(NSArray<TestDataModel *> *modelArray))success {
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0.1), ^{
      
      //获取数据
      NSString *path = [[NSBundle mainBundle] pathForResource:@"TestData" ofType:@"plist"];
      NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
      
      //数据转模型
      NSMutableArray *modelArray = [NSMutableArray array];
      [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
          TestDataModel *model = [TestDataModel new];
          model.title = key;
          model.detailTitle = obj;
          model.type = arc4random() % 2;  //模拟服务器动态类型下发
          [modelArray addObject:model];
      }];
      
      dispatch_async(dispatch_get_main_queue(), ^{
          success(modelArray);
      });
  });
}

@end
