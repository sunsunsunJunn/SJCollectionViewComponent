//
//  SJCollectionViewSection.m
//  SJCollectionViewComponent
//
//  Created by SUNJUN on 2020/3/16.
//  Copyright © 2020 SUNJUN. All rights reserved.
//

#import "SJCollectionViewSection.h"

@interface SJCollectionViewSection ()

@property (nonatomic, strong) NSMutableArray<id<SJCollectionViewCellModelProtocol>> *rowArray;

@end

@implementation SJCollectionViewSection

- (NSMutableArray<id<SJCollectionViewCellModelProtocol>> *)rowArray {
    if (!_rowArray) {
        _rowArray = [NSMutableArray array];
    }
    return _rowArray;
}

@end
